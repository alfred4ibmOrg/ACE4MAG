# LAB 3. Content Transformation

In this lab, you will create a fully functional Multi-Protocol gateway service that will transform message from REST (JSON) to SOAP (XML) and from SOAP (XML) to REST (JSON).

Upon completing this lab, you will have a better understanding of:

- How messages are processed
- The Multi-Protocol Gateway service configuration
- Front-side protocol handlers
- Configuring Processing Policies, Rules, and Actions
- Developing on XSLT to transform the content of the messages

The following image shows the overall idea of this lab. There are REST clients which send requests and backends which are designed to process SOAP. In the middle, there is a DataPower exposing REST facade against a SOAPful web service as the backend. DataPower has a Multi-Protocol gateway service which accepts RESTful methods requests (GET, PUT, POST, DELETE) from the service consumer. Then, this service will transform the structure of the messages in both ways: REST-SOAP and SOAP-REST.

![](./images/DP-MPGW-REST-SOAP.png)

**1.** The first step is to verify that the backend service is up and running. We will use a public web service from DataAccess as the backend in this lab. The web service allows the conversions from numbers to words (English). To validate the status of the backend, you will open a new terminal (command line) and run the next command.

```
curl -X POST --header "Content-Type: text/xml" --header "charset: utf-8" -d '<?xml version="1.0" encoding="utf-8"?> <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"> <soap:Body> <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/"> <ubiNum>500</ubiNum> </NumberToWords> </soap:Body> </soap:Envelope>' https://www.dataaccess.com/webservicesserver/NumberConversion.wso
```

**2.** The output should be like the following answer. The web service converts the number ‘500’ into words ‘five hundred’.

```
[techzone@rhel9-base ~]$ curl -X POST --header "Content-Type: text/xml" --header "charset: utf-8" -d '<?xml version="1.0" encoding="utf-8"?> <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"> <soap:Body> <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/"> <ubiNum>500</ubiNum> </NumberToWords> </soap:Body> </soap:Envelope>' https://www.dataaccess.com/webservicesserver/NumberConversion.wso
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <m:NumberToWordsResponse xmlns:m="http://www.dataaccess.com/webservicesserver/">
      <m:NumberToWordsResult>five hundred </m:NumberToWordsResult>
    </m:NumberToWordsResponse>
  </soap:Body>
</soap:Envelope>
[techzone@rhel9-base ~]$
```

**3.** Now that you have verified that the service is accessible and operational, you are ready to configure a Multi-Protocol Gateway that will mediate between REST/JSON and SOAP/XML. Navigate your browser to the following secure URL:
```
https://127.0.0.1:9090
```

**4.** Put your username and password in the appropriate fields, and then click **Login.**

![](./images/DP-LAB3-00004.png)

**5.** Upon successful login, the DataPower Control Panel will be shown.

![](./images/DP-LAB3-00005.png)

**6.** Click the Services tab and click on Multi-Protocol Gateway option.

![](./images/DP-LAB3-00006.png)

**7.** Click the **Add** button to create a new Muti-Protocol Gateway service. The New Multi-Protocol Gateway form will be displayed.

![](./images/DP-LAB3-00007.png)

**8.** In the Multi-Protocol Gateway Name field, type: **NumberToWords_MPG**

![](./images/DP-LAB3-00008.png)

**9.** In the XML Manager section, click the **‘+’** button. The XML Manager form will be displayed.

![](./images/DP-LAB3-00009.png)

**10.** In the Name field, type: **NumberToWords-XMLManager**

![](./images/DP-LAB3-00010.png)

**11.** Scroll down to find the User Agent Configuration field, click the **‘+’** button. The User Agent form will be displayed.

![](./images/DP-LAB3-00011.png)

**12.** In the Name field, type: **NumberToWords-UserAgent.** Click the **Apply** button in the upper section of the form.

![](./images/DP-LAB3-00012.png)

**13.** A successful message should be displayed. Click the **‘x’** button. Click the **Apply** button.

![](./images/DP-LAB3-00013.png)

**14.** A successful message should be displayed. Click the **‘x’** button.

![](./images/DP-LAB3-00014.png)

**15.** The new XML Manager should be automatically added to the list of XML Manager.

![](./images/DP-LAB3-00015.png)

**16.** In the Processing policy section, click the **‘+’** button. The Configure Multi-Protocol Gateway Style Policy form will be displayed.

![](./images/DP-LAB3-00016.png)

**17.** In the Policy Name field, type: **NumberToWords-StylePolicy.** Then, click the **Add** button to create processing rules.

![](./images/DP-LAB3-00017.png)

**18.** In the Rule Name field, type: **NumberToWords-StylePolicy_request.** In the Rule Direction dropdown, select the option: **Client to Server**

![](./images/DP-LAB3-00018.png)

**19.** Click the **Match rule** action to reveal its configuration form in a pop-up window.

![](./images/DP-LAB3-00019.png)

**20.**	Click the **‘+’** button. The Matching Rule form will be displayed.

![](./images/DP-LAB3-00020.png)

**21.** In the Name field, type: **NumberToWords-MatchingRule-All**

![](./images/DP-LAB3-00021.png)

**22.** Scroll down to find the Rules section, click the **Add** button. The Add Rules form will be displayed.

![](./images/DP-LAB3-00022.png)

**23.** Leave the Matching type field as URL. In the URL match field, type: *****. Then, click the **Apply** button.

![](./images/DP-LAB3-00023.png)

**24.** The new Matching type should be automatically added.

![](./images/DP-LAB3-00024.png)

**25.** Click the **Apply** button in the upper section of the form.

![](./images/DP-LAB3-00025.png)

**26.**	A successful message should be displayed. Click the **‘x’** button. The new Matching Rule should be automatically added. Then, click the **Done** button.

![](./images/DP-LAB3-00026.png)

**27.**	In the Rule section, click the **Done** button.

![](./images/DP-LAB3-00027.png)

**28.** The new Rule should be automatically added. Click the **Add** button to create a response rule.

![](./images/DP-LAB3-00028.png)

**29.**	In the Rule Name field, type: **NumberToWords-StylePolicy_response.** In the Rule Direction dropdown, select the option: **Server to Client.**

![](./images/DP-LAB3-00029.png)

**30.**	Click the **Match rule** action to reveal its configuration form in a pop-up window.

![](./images/DP-LAB3-00030.png)

**31.**	In the Matching Rule dropdown, select: **NumberToWords-MatchingRule-All.** Then, click the **Done** button.

![](./images/DP-LAB3-00031.png)

**32.**	In the Rule section, click the **Done** button.

![](./images/DP-LAB3-00032.png)

**33.**	The new Rule should be automatically added. There should be two (2) rules. Click the **Apply Policy** button to create the style policy.

![](./images/DP-LAB3-00033.png)

**34.**	A successful message should be displayed. Click the **‘x’** button. The new Style Policy should be created. Then, click the **‘x’** button in the Configure Multi-Protocol Gateway Style Policy tab.

![](./images/DP-LAB3-00034.png)

**35.**	In the Default Backend URL field, type:

```
https://www.dataaccess.com
```

![](./images/DP-LAB3-00035.png)

**36.**	In the TLS client type field, select the option: **Client profile.** Then, select the **‘+’** button in the TLS client profile field.

![](./images/DP-LAB3-00036.png)

**37.**	In the Name field, type: **NumberToWords-TLSClient**

![](./images/DP-LAB3-00037.png)

**38.**	Scroll down to the Credentials section. Turn off **Validate server certificate.**

![](./images/DP-LAB3-00038.png)

**39.**	Click the **Apply** button in the upper section of the form.

![](./images/DP-LAB3-00039.png)

**40.**	A successful message should be displayed.

![](./images/DP-LAB3-00040.png)

**41.**	In Response type field, select the option: **SOAP**

![](./images/DP-LAB3-00041.png)

**42.**	In Front side settings section, click the **‘+’** button.

![](./images/DP-LAB3-00042.png)

**43.**	In the pop-up list of Front Side Protocol, select the option: **HTTP handler.** The HTTP handler form will be displayed.

![](./images/DP-LAB3-00043.png)

**44.**	In the Name field, type: **NumberToWords-HTTPHandler**

**45.**	Leave the Local IP address field as 0.0.0.0. This will cause the front side handler to listen for traffic on all IP addresses defined on the appliance.

**46.**	In the Port field, replace the default port 80 with 8000.

![](./images/DP-LAB3-00046.png)

**47.**	In the **Allowed methods and versions** field, select the **GET method**. Click the **Apply** button in the upper section of the form.

![](./images/DP-LAB3-00047.png)

**48.**	A successful message should be displayed.

![](./images/DP-LAB3-00048.png)

**49.**	The new HTTP FSH should be automatically added to the dropdown list of Front Side Protocol (see below). Then, click the **Add** button.

![](./images/DP-LAB3-00049.png)

**50.**	The HTTP FSH should be added to the list of Front Side Protocol (see below).

![](./images/DP-LAB3-00050.png)

**51.**	In Request type field, select the option: **JSON**

![](./images/DP-LAB3-00051.png)

**52.**	Click the **Apply** button in the upper section of the form to activate this new configuration.

![](./images/DP-LAB3-00052.png)

**53.**	The service should be created, and the status should be **‘up’**. The Multi-Protocol Gateway.

![](./images/DP-LAB3-00053.png)

**54.**	At the top of the browser window, click on the **Save** button.

![](./images/DP-LAB3-00054.png)

**55.**	You should see a message that says the domain configuration was successfully saved.

![](./images/DP-LAB3-00055.png)

**56.**	Now, it is time to add some actions to the processing rule. Click on the **Edit (pencil)** button in the Processing policy field.

![](./images/DP-LAB3-00056.png)

57.	In the rule sections, click on the Rule Name which has direction as “Client to Server”.

![](./images/DP-LAB3-00057.png)

**58.**	Click on the **‘+’** button to add a new action.

![](./images/DP-LAB3-00058.png)

**59.**	Scroll down to the Advanced actions section, click on the **“Convert Query Params to XML”.**

![](./images/DP-LAB3-00059.png)

**60.**	Click the **“Convert Query Params to XML”** action to provide the configuration details.

![](./images/DP-LAB3-00060.png)

**61.**	Click on the Done button.

![](./images/DP-LAB3-00061.png)

**62.**	Click on the **‘+’** button to add a new action.

![](./images/DP-LAB3-00062.png)

**63.**	In the Actions section, click on the **Transform** icon.

![](./images/DP-LAB3-00063.png)

**64.**	Click the **“Transform”** action to provide the configuration details.

![](./images/DP-LAB3-00064.png)

**65.**	Click on the “Upload Files” button.

![](./images/DP-LAB3-00065.png)

**66.**	Click the **“Drag and drop files or click to upload”** link.

![](./images/DP-LAB3-00066.png)

**67.**	Click on the **Home** button. Then, go to the **tools/files** folder. Select the XSL file.

![](./images/DP-LAB3-00067.png)

**68.**	Click on the **Upload** button.

![](./images/DP-LAB3-00068.png)

**69.**	A successful message should be displayed.

![](./images/DP-LAB3-00069.png)

**70.**	The file should be added automatically. Click on **Done** button.

![](./images/DP-LAB3-00070.png)

**71.**	Click on the **‘+’** button to add a new action.

![](./images/DP-LAB3-00071.png)

**72.**	In the Advanced action section, click the **Method Rewrite** icon.

![](./images/DP-LAB3-00072.png)

**73.**	Click the **“Method Rewrite”** action to provide the configuration details.

![](./images/DP-LAB3-00073.png)

**74.**	In the list of Method, select the option: **POST.** Then, click on the **Done** button.

![](./images/DP-LAB3-00074.png)

**75.**	Click on the **Done** button.

![](./images/DP-LAB3-00075.png)

**76.**	Click on the **Apply Policy** button.

![](./images/DP-LAB3-00076.png)

**77.**	A successful message should be displayed.

![](./images/DP-LAB3-00077.png)

78.	In the rule sections, click on the Rule Name which has direction as “Server to Client”.

![](./images/DP-LAB3-00078.png)

**79.**	Click on the **‘+’** button to add a new action.

![](./images/DP-LAB3-00079.png)

**80.**	In the Actions section, click on the **Transform** icon.

![](./images/DP-LAB3-00080.png)

81.	Click the **“Transform”** action to provide the configuration details.

![](./images/DP-LAB3-00081.png)

82.	Click on the **“Upload Files”** button.

![](./images/DP-LAB3-00082.png)

83.	Click the **“Drag and drop files or click to upload”** link.

![](./images/DP-LAB3-00083.png)

84.	Click on the **Home** button. Then, go to the **tools/files** folder. Select the XSL file.

![](./images/DP-LAB3-00084.png)

**85.**	Click on the **Upload** button.

![](./images/DP-LAB3-00085.png)

**86.**	A successful message should be displayed.

![](./images/DP-LAB3-00086.png)

**87.**	The file should be added automatically. Click on **Done** button.

![](./images/DP-LAB3-00087.png)

**88.**	Click on the **‘+’** button to add a new action.

![](./images/DP-LAB3-00088.png)

**89.**	In the Actions section, click on the **Transform** icon.

![](./images/DP-LAB3-00089.png)

**90.**	In the Select a directory field, select **“store:///”.** Then, select the **“jsonx2json.xsl”** file. Click on the **Done** button.

![](./images/DP-LAB3-00090.png)

**91.**	Click on the **Done** button.

![](./images/DP-LAB3-00091.png)

**92.**	Click on the **Apply Policy** button.

![](./images/DP-LAB3-00092.png)

**93.**	A successful message should be displayed.

![](./images/DP-LAB3-00093.png)

**94.**	In the search field, type the word “file”. In the search results, locate and select: **File Management.**

![](./images/DP-LAB3-00094.png)

**95.**	In the local folder, click the three vertical dots to open the action menu. Then, click **Upload Files.**

![](./images/DP-LAB3-00095.png)

**96.**	Click on the **Home** button. Then, go to the **tools/files** folder. Select the XML file.

![](./images/DP-LAB3-00096.png)

**97.**	Click on the **Upload** button.

![](./images/DP-LAB3-00097.png)

**98.**	A successful message should be displayed.

**99.**	Open a terminal, run the curl command to test the service. The output should be a JSON message with the conversion of the number to words. For example, 400 into four hundred.

```
[techzone@rhel9-base ~]$ curl --request GET http://127.0.0.1:8000/getNumberConversion?ubiNum=400
{ "NumberToWordsResult":"four hundred " }
[techzone@rhel9-base ~]$
![image](https://media.github.ibm.com/user/75211/files/47c9effe-9878-4ec3-82fc-2a8af9c1ebfb)
```

**This is the end of lab 3. Congratulations!**
