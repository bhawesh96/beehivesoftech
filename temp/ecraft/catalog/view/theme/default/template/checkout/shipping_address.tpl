<?php if ($addresses) { ?>
<input type="radio" name="shipping_address" value="existing" id="shipping-address-existing" checked="checked" />
<label for="shipping-address-existing"><?php echo $text_address_existing; ?></label>
<div id="shipping-existing">
  <select name="address_id" style="width: 100%; margin-bottom: 15px;" size="5">
    <?php foreach ($addresses as $address) { ?>
    <?php if ($address['address_id'] == $address_id) { ?>
    <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
    <?php } ?>
    <?php } ?>
  </select>
</div>
<p>
  <input type="radio" name="shipping_address" value="new" id="shipping-address-new" />
  <label for="shipping-address-new"><?php echo $text_address_new; ?></label>
</p>
<?php } ?>
<div id="shipping-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
  <table class="form">
    <tr>
      <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
      <td><input type="text" name="firstname" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
      <td><input type="text" name="lastname" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><?php echo $entry_company; ?></td>
      <td><input type="text" name="company" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
      <td><input type="text" name="address_1" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><?php echo $entry_address_2; ?></td>
      <td><input type="text" name="address_2" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_city; ?></td>
      <td><input type="text" name="city" value="" class="large-field" /> </td>
    </tr>
    <tr>
      <td><span id="shipping-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
      <td><input type="text" name="postcode" id="Shippostcode" value="<?php echo $postcode; ?>" class="large-field" />
      <input type="hidden" name="avlpostcode" id="avlShippostcode" value="" />
      </td>
    </tr>
   <tr id="ZipRow"><td colspan="2" id="tempzipcode"></td></tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_country; ?></td>
      <td><select name="country_id" class="large-field">
          <option value=""><?php echo $text_select; ?></option>
          <?php foreach ($countries as $country) { ?>
          <?php if ($country['country_id'] == $country_id) { ?>
          <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
          <?php } ?>
          <?php } ?>
        </select></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
      <td><select name="zone_id" class="large-field">
        </select></td>
    </tr>
  </table>
</div>
<br />
<div class="buttons">
  <div class="right">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-shipping-address" class="button" />
  </div>
</div>
<script type="text/javascript"><!--
$('#shipping-address input[name=\'shipping_address\']').live('change', function() {
	if (this.value == 'new') {
		$('#shipping-existing').hide();
		$('#shipping-new').show();
	} else {
		$('#shipping-existing').show();
		$('#shipping-new').hide();
	}
});
//--></script> 
<script type="text/javascript"><!--
$('#shipping-address select[name=\'country_id\']').bind('change', function() {
	if (this.value == '') return;
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#shipping-postcode-required').show();
			} else {
				$('#shipping-postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#shipping-address select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#shipping-address select[name=\'country_id\']').trigger('change');

// Search delevery using Pincode

$('#Shippostcode').bind('change', function() {
	//alert('hi');
	$('.success').fadeOut('fast').delay(1000);
$.ajax({
			url: 'https://indianpost.p.mashape.com/getOffices.php',
			type: 'GET',
			data: { pincode: $('#Shippostcode').val() },
			datatype: 'json',
			success: function (data)
			 {
				$('.success, .warning, .attention, information, .error').remove();
						
					var dataObj = JSON.parse(data);
				if(dataObj.error)
					{
											
					$('#tempzipcode').html('<div class="warning" style="display: none;">Delivery not available or  ' + dataObj.error + ' Please use another postcode.<img src="catalog/view/theme/default/image/close.png" alt="" class="close" id="closedDiv" /></div>');					
				$('.warning').fadeIn('fast').delay(1000);
				$('#button-shipping-address').hide('fast');
					}
				else{
				
				$('#tempzipcode').html('<div class="success" style="display: none;">Delivery available to ' + dataObj.results[0].divisionname + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" id="closedDiv" /></div>');					
				$('.success').show('fast');
				$('#button-shipping-address').show('fast');
				
				}
																	
			},
			error: function (err) {
			$('#tempzipcode').html(err);
			},
			beforeSend: function (xhr) {
			xhr.setRequestHeader("X-Mashape-Authorization", "jxBZm0Pxj46weTKYecEC882tPRVNEg4p");
			}
		});

});
$(document).ready(function () {
				
			$('#closedDiv').bind('click', function() {
				  $('#temp_zipcode').fadeOut('fast');
			});
			//$('#ZipRow').hide();
//-------------------------------------------
$.ajax({
			url: 'https://indianpost.p.mashape.com/getOffices.php',
			type: 'GET',
			data: { pincode: $('#Shippostcode').val() },
			datatype: 'json',
			success: function (data)
			 {
				var dataObj = JSON.parse(data);
				//$("#tempzipcode").html(data);
				//$('#ZipRow').show('fast');
				if(dataObj.error)
					{
											
			$('#tempzipcode').html('<div class="warning" style="display: none;">Delivery not available or  ' + dataObj.error + ' Please use another postcode.<img src="catalog/view/theme/default/image/close.png" alt="" class="close" id="closedDiv" /></div>');					
			$('.warning').fadeIn('fast').delay(1000);
			$('#button-shipping-address').hide('fast');
					}
				else{
				
				$('#tempzipcode').html('<div class="success" style="display: none;">Delivery available to ' + dataObj.results[0].divisionname + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" id="closedDiv" /></div>');					
				$('.success').show('fast');
				$('#button-shipping-address').show('fast');
				
				}
				
																	
			},
			error: function (err) {
			$('#tempzipcode').html(err);
			},
			beforeSend: function (xhr) {
			xhr.setRequestHeader("X-Mashape-Authorization", "jxBZm0Pxj46weTKYecEC882tPRVNEg4p");
			}
		});
});
	
//--></script>