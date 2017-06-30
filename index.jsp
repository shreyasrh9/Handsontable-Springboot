---
layout: default
title: Home
---

<div class="img">
    <img src="http://res.cloudinary.com/shreyas/image/upload/v1447835724/_20150603_122529_a3k9rn.jpg" />
</div>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/lz-string.js"></script>
<!-- <script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/handsontable/0.32.0/handsontable.full.css">
<link rel="stylesheet" type="text/css"
	href="https://handsontable.com/static/css/main.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"
	integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
	integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ"
	crossorigin="anonymous">
	
<script src="https://docs.handsontable.com/0.18.0/bower_components/handsontable/dist/handsontable.full.js"></script>

<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Open+Sans" />
	
	<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
	
	
<title>Handson Example</title>

<style type="text/css">
.btn {
	margin-top: 1%;
}

.Welcome-Screen {
	/* background-color: #f1ece1; */
	background: #f5f5f5 url(images/subtle_white_feathers.png)
}
</style>
</head>
<body class="Welcome-Screen" style="font-family: Open-Sans;overflow-y:scroll;font-size:20px  
    ">

	<nav
		class="WelcomeNav navbar navbar-toggleable-md navbar-light bg-faded">
	<button class="navbar-toggler navbar-toggler-right" type="button"
		data-toggle="collapse" data-target="#navbarNav"
		aria-controls="navbarNav" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarNav">
		<ul class="navbar-nav">
			<li class="nav-item active"></li>
			<li class="nav-item"></li>
			<li class="nav-item"></li>

		</ul>
	</div>
	</nav>
	<div class="container-fluid" >
	
	<div style="text-align: center;" >
    
    <h1 style="position:absolute">Handson Table</h1>
	</div>
	</div>
		

			<div id="hot" style="margin-top:8%;position:relative">
				
			</div>

		
		
		<div class="container-fluid" >
		
		<button type="button" class="btn btn-primary btn-sm" name="dump1">Check
				Compressed Data</button>
		
		<button type="button" class="btn btn-info btn-sm" name="dump">Check 
				Normal Data</button>
				
		
		<div class="col-xs-12" style="margin-top: 15px; padding: 15px;">

			
				<div class="form-group">
					<div class="row">

						<div class="col-xs-6">
							<label class="control-label">Normal Data</label>
							<textarea class="form-control" rows="5" id="data"
								style="margin-top: 5px; margin-bottom: 10px;"></textarea>
						</div>

						<div class="col-xs-6">
							<label class="control-label">Compressed Data</label>
							<textarea class="form-control" rows="5" id="data_compressed" 
								style="margin-top: 5px; margin-bottom: 10px;"></textarea>
						</div>

					</div>

				</div>

			

		</div>


		<p><ul>
  <li>1. In this example we will see how to handle a requirement where a user wants to upload a huge excel sheet data and validate the data in our controller.</li>
  <li>2. Each row will be validated.</li>
  <li>3. As you can see the first column header says message where any error messages will be displayed in that column.</li>
  <li>4. If you want to submit a huge data, there are chances where a variable which is binded can be null in the controller as there are some limitations on the size of data that is being submitted. So what do we do now???</li>
  <li>5. We will compress the data in JSP and decompress in the controller.</li>
  <li>6. We will use lz-string to compress and decompress.</li>
  <li>7. Add lz-string js to your JSP <code>&lt;script language="javascript" src="lz-string.js"&gt;&lt;/script&gt;</code> </li>
  <li>8. Add the below code to compress the handson table data.<code>
		var compressed = LZString.compress(hot.getData());<br>
	</code> </li>
  <li>9. Decompress the compressed data in your controller using the below code.
  		<code>JSPath = Your JS path; <br><br>
		
		File fileJS = null;<br>
		ScriptEngineManager mgr = null;<br>
		ScriptEngine engine = null;<br>
		String contentJS = null;<br><br>

		fileJS = new File(JSPath);<br>
		mgr = new ScriptEngineManager();<br>
		engine = mgr.getEngineByName("JavaScript");<br>
		contentJS = FileUtils.readFileToString(fileJS, "UTF-8");<br>
		engine.eval(contentJS);<br>
		engine.eval("var decompressedJSON = LZString.decompressFromEncodedURIComponent('" + compressedJSON + "')");<br>
		System.out.println((String) engine.get("decompressedJSON"));</code></li>
			<li>10. Now we will remove the rows if they are empty so that we
				avoid unnecessary loop. <code>
					Type listType = null;<br> listType = new
					TypeToken&lt;List&lt;HandsOnTable&gt;&gt;() { }.getType();<br>
					List&lt;HandsOnTable&gt; bdpmbList = new
					GsonBuilder().create().fromJson(bulkData, listType); <br>
					for (int i =0; i < bdpmbList.size(); i++) { <br>
					if(bdpmbList.get(i).isEmptyBulkData()) { <br>
					bdpmbList.remove(i); i--; <br>
					}<br>
					
				</code>
			</li>
			<li>11. Now let's validate each rows and set error messages to first column. Enter a non numerical value in any cell and click on upload data</li>
  
</ul> </p>


</div>
	
		
<script type="text/javascript">

$( document ).ready(function() {
	
	  var dataObject = ${handsOnJson};
	  
	  console.log(dataObject);
	  var container = document.getElementById('hot');
	  
			var hot = new Handsontable(container, {
			  data: dataObject,
			    columns: [
			    	{data : 'message'},
			    	{data : 'column1'},{data : 'column2'},{data : 'column3'},{data : 'column4'},{data : 'column5'},{data : 'column6'},{data : 'column7'},{data : 'column8'},{data : 'column9'},{data : 'column10'},{data : 'column11'},{data : 'column12'},{data : 'column13'},{data : 'column14'},{data : 'column15'},{data : 'column16'},{data : 'column17'},{data : 'column18'},{data : 'column19'},{data : 'column20'},{data : 'column21'},{data : 'column22'},{data : 'column23'},{data : 'column24'},{data : 'column25'},{data : 'column26'},{data : 'column27'},{data : 'column28'},{data : 'column29'},{data : 'column30'},{data : 'column31'},{data : 'column32'},{data : 'column33'},{data : 'column34'},{data : 'column35'},{data : 'column36'},{data : 'column37'},{data : 'column38'},{data : 'column39'},{data : 'column40'},{data : 'column41'},{data : 'column42'},{data : 'column43'},{data : 'column44'},{data : 'column45'},{data : 'column46'},{data : 'column47'},{data : 'column48'},{data : 'column49'},{data : 'column50'},{data : 'column51'},{data : 'column52'},{data : 'column53'},{data : 'column54'},{data : 'column55'},{data : 'column56'},{data : 'column57'},{data : 'column58'},{data : 'column59'},{data : 'column60'},{data : 'column61'},{data : 'column62'},{data : 'column63'},{data : 'column64'},{data : 'column65'},{data : 'column66'},{data : 'column67'},{data : 'column68'},{data : 'column69'},{data : 'column70'},{data : 'column71'},{data : 'column72'},{data : 'column73'},{data : 'column74'},{data : 'column75'},{data : 'column76'},{data : 'column77'},{data : 'column78'},{data : 'column79'},{data : 'column80'},{data : 'column81'},{data : 'column82'},{data : 'column83'},{data : 'column84'},{data : 'column85'},{data : 'column86'},{data : 'column87'},{data : 'column88'},{data : 'column89'},{data : 'column90'},{data : 'column91'},{data : 'column92'},{data : 'column93'},{data : 'column94'},{data : 'column95'},{data : 'column96'},{data : 'column97'},{data : 'column98'},{data : 'column99'},{data : 'column100'},{data : 'column101'},{data : 'column102'},{data : 'column103'},{data : 'column104'},{data : 'column105'},{data : 'column106'},{data : 'column107'},{data : 'column108'},{data : 'column109'},{data : 'column110'},{data : 'column111'},{data : 'column112'},{data : 'column113'},{data : 'column114'},{data : 'column115'},{data : 'column116'},{data : 'column117'},{data : 'column118'},{data : 'column119'},{data : 'column120'},{data : 'column121'},{data : 'column122'},{data : 'column123'},{data : 'column124'},{data : 'column125'},{data : 'column126'},{data : 'column127'},{data : 'column128'},{data : 'column129'},{data : 'column130'},{data : 'column131'},{data : 'column132'},{data : 'column133'},{data : 'column134'},{data : 'column135'},{data : 'column136'},{data : 'column137'},{data : 'column138'},{data : 'column139'},{data : 'column140'},{data : 'column141'},{data : 'column142'},{data : 'column143'},{data : 'column144'},{data : 'column145'},{data : 'column146'},{data : 'column147'},{data : 'column148'},{data : 'column149'},{data : 'column150'},{data : 'column151'},{data : 'column152'},{data : 'column153'},{data : 'column154'},{data : 'column155'},{data : 'column156'},{data : 'column157'},{data : 'column158'},{data : 'column159'},{data : 'column160'},{data : 'column161'},{data : 'column162'},{data : 'column163'},{data : 'column164'},{data : 'column165'},{data : 'column166'},{data : 'column167'},{data : 'column168'},{data : 'column169'},{data : 'column170'},{data : 'column171'},{data : 'column172'},{data : 'column173'},{data : 'column174'},{data : 'column175'},{data : 'column176'},{data : 'column177'},{data : 'column178'},{data : 'column179'},{data : 'column180'},{data : 'column181'},{data : 'column182'},{data : 'column183'},{data : 'column184'},{data : 'column185'},{data : 'column186'},{data : 'column187'},{data : 'column188'},{data : 'column189'},{data : 'column190'},{data : 'column191'},{data : 'column192'},{data : 'column193'},{data : 'column194'},{data : 'column195'},{data : 'column196'},{data : 'column197'},{data : 'column198'},{data : 'column199'},{data : 'column200'},{data : 'column201'},{data : 'column202'},{data : 'column203'},{data : 'column204'},{data : 'column205'},{data : 'column206'},{data : 'column207'},{data : 'column208'},{data : 'column209'},{data : 'column210'},{data : 'column211'},{data : 'column212'},{data : 'column213'},{data : 'column214'},{data : 'column215'},{data : 'column216'},{data : 'column217'},{data : 'column218'},{data : 'column219'},{data : 'column220'},{data : 'column221'},{data : 'column222'},{data : 'column223'},{data : 'column224'},{data : 'column225'},{data : 'column226'},{data : 'column227'},{data : 'column228'},{data : 'column229'},{data : 'column230'},{data : 'column231'},{data : 'column232'},{data : 'column233'},{data : 'column234'},{data : 'column235'},{data : 'column236'},{data : 'column237'},{data : 'column238'},{data : 'column239'},{data : 'column240'},{data : 'column241'},{data : 'column242'},{data : 'column243'},{data : 'column244'},{data : 'column245'},{data : 'column246'},{data : 'column247'},{data : 'column248'},{data : 'column249'},{data : 'column250'},{data : 'column251'},{data : 'column252'},{data : 'column253'},{data : 'column254'},{data : 'column255'},{data : 'column256'},{data : 'column257'},{data : 'column258'},{data : 'column259'},{data : 'column260'},{data : 'column261'},{data : 'column262'},{data : 'column263'},{data : 'column264'},{data : 'column265'},{data : 'column266'},{data : 'column267'},{data : 'column268'},{data : 'column269'},{data : 'column270'},{data : 'column271'},{data : 'column272'},{data : 'column273'},{data : 'column274'},{data : 'column275'},{data : 'column276'},{data : 'column277'},{data : 'column278'},{data : 'column279'},{data : 'column280'},{data : 'column281'},{data : 'column282'},{data : 'column283'},{data : 'column284'},{data : 'column285'},{data : 'column286'},{data : 'column287'},{data : 'column288'},{data : 'column289'},{data : 'column290'},{data : 'column291'},{data : 'column292'},{data : 'column293'},{data : 'column294'},{data : 'column295'},{data : 'column296'},{data : 'column297'},{data : 'column298'},{data : 'column299'},{data : 'column300'},{data : 'column301'},{data : 'column302'},{data : 'column303'},{data : 'column304'},{data : 'column305'},{data : 'column306'},{data : 'column307'},{data : 'column308'},{data : 'column309'},{data : 'column310'},{data : 'column311'},{data : 'column312'},{data : 'column313'},{data : 'column314'},{data : 'column315'},{data : 'column316'},{data : 'column317'},{data : 'column318'},{data : 'column319'},{data : 'column320'},{data : 'column321'},{data : 'column322'},{data : 'column323'},{data : 'column324'},{data : 'column325'},{data : 'column326'},{data : 'column327'},{data : 'column328'},{data : 'column329'},{data : 'column330'},{data : 'column331'},{data : 'column332'},{data : 'column333'},{data : 'column334'},{data : 'column335'},{data : 'column336'},{data : 'column337'},{data : 'column338'},{data : 'column339'},{data : 'column340'},{data : 'column341'},{data : 'column342'},{data : 'column343'},{data : 'column344'},{data : 'column345'},{data : 'column346'},{data : 'column347'},{data : 'column348'},{data : 'column349'},{data : 'column350'},{data : 'column351'},{data : 'column352'},{data : 'column353'},{data : 'column354'},{data : 'column355'},{data : 'column356'},{data : 'column357'},{data : 'column358'},{data : 'column359'},{data : 'column360'},{data : 'column361'},{data : 'column362'},{data : 'column363'},{data : 'column364'},{data : 'column365'},
			    	
			    	],
			    /* stretchH: 'all',
			    autoWrapRow: true, */
			    minRows : 10,
			    minSpareRows : 1,
			    rowHeaders: true,
			    
			    
			    cells: function (row, col, prop) {
			    	var cellProperties = {};
			    	 if(row == '0'){
						  cellProperties.readOnly = true;
						  cellProperties.renderer = firstRowRenderer; // uses function directly
					  }
					  
					  if(row == '0' && col == '0'){
						  cellProperties.renderer = makeMeRed; // uses function directly
					  }
					  
					  if(col == '0'){
						  cellProperties.readOnly = true;
					  }
					    
					  return cellProperties;
				}
			   
	  });
	  
	  function firstRowRenderer(instance, td, row, col, prop, value, cellProperties) {
		    Handsontable.renderers.TextRenderer.apply(this, arguments);
		    td.style.fontWeight = 'bold';
		    td.style.color = 'green';
		    td.style.background = '#CEC';
		  }
	  
	  function makeMeRed(instance, td, row, col, prop, value, cellProperties) {
		    Handsontable.renderers.TextRenderer.apply(this, arguments);

		      td.style.color = 'red';
		      td.style.background = '#CEC';
		    
	  }
	  
	  function typeIdentifiers(instance, td, row, col, prop, value, cellProperties) {
		    Handsontable.renderers.TextRenderer.apply(this, arguments);
		    td.title='';
		}
	  
	  
	  function bindDumpButton() {
			$('body')
					.on(
							'click',
							'button[name=dump]',
							function() {
								var dump = $(this).data(
										'dump');
								var $container = $(dump);
								
								$('#data').val(JSON
										.stringify(hot.getData()));
								console.log(JSON
								.stringify(hot.getData()));
							});
			
			$('body')
			.on(
					'click',
					'button[name=dump1]',
					function() {
						var dump = $(this).data(
								'dump');
						var $container = $(dump);
						var normal = JSON
						.stringify(hot.getData());
						
						var compressed = LZString.compressToEncodedURIComponent(normal);
						
						$('#data_compressed').val(compressed);
					});
			
			
		}
		bindDumpButton();
});

</script>

</body>
</html> 
