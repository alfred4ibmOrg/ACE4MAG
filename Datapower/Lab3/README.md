# LAB 3. Content Transformation

In this lab, you will create a fully functional Multi-Protocol gateway service that will transform message

Upon completing this lab, you will have a better understanding of:

- How messages are processed
- The Multi-Protocol Gateway service configuration
- Front-side protocol handlers
- Configuring Processing Policies, Rules, and Actions
- Developing on XSLT to transform the content of the messages

The following image shows the overall idea of this lab. There are REST clients which send requests and backends which are designed to process it. In the middle, there is a DataPower exposing REST facade against a web server as the backend. DataPower has a Multi-Protocol gateway service which accepts RESTful methods requests (GET, PUT, POST, DELETE) from the service consumer. Then, this service will transform the structure of the messages in both ways. (IGNORE SOAP BOX AT IMAGE BELOW AS WE DONT USE SOAP CONVERTER FOR NOW)

![](./images/DP-MPGW-REST-SOAP.png)

**1.** The first step is to verify that the backend service is up and running. We will use a public web service from public website to echo our HEADER as the backend in this lab.

https://echo.free.beeceptor.com/

**3.** Now that you have verified that the service is accessible and operational, you are ready to configure a Multi-Protocol Gateway that will mediate between your curl HTTP request with that public website. Navigate your browser to the following secure URL:
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

**8.** In the Multi-Protocol Gateway Name field, type: **test_MPG**

![](./images/DP-LAB3-00008.png)

**9.** In the XML Manager section, click the **‘+’** button. The XML Manager form will be displayed.

![](./images/DP-LAB3-00009.png)

**10.** In the Name field, type: **test-XMLManager**

![](./images/DP-LAB3-00010.png)

**11.** Scroll down to find the User Agent Configuration field, click the **‘+’** button. The User Agent form will be displayed.

![](./images/DP-LAB3-00011.png)

**12.** In the Name field, type: **test-UserAgent.** Click the **Apply** button in the upper section of the form.

![](./images/DP-LAB3-00012.png)

**13.** A successful message should be displayed. Click the **‘x’** button. Click the **Apply** button.

![](./images/DP-LAB3-00013.png)

**14.** A successful message should be displayed. Click the **‘x’** button.

![](./images/DP-LAB3-00014.png)

**15.** The new XML Manager should be automatically added to the list of XML Manager.

![](./images/DP-LAB3-00015.png)

**16.** In the Processing policy section, click the **‘+’** button. The Configure Multi-Protocol Gateway Style Policy form will be displayed.

![](./images/DP-LAB3-00016.png)

**17.** In the Policy Name field, type: **test-StylePolicy.** Then, click the **Add** button to create processing rules.

![](./images/DP-LAB3-00017.png)

**18.** In the Rule Name field, type: **test-StylePolicy_request.** In the Rule Direction dropdown, select the option: **Client to Server**

![](./images/DP-LAB3-00018.png)

**19.** Click the **Match rule** action to reveal its configuration form in a pop-up window.

![](./images/DP-LAB3-00019.png)

**20.**	Click the **‘+’** button. The Matching Rule form will be displayed.

![](./images/DP-LAB3-00020.png)

**21.** In the Name field, type: **test-MatchingRule-All**

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

**29.**	In the Rule Name field, type: **test-StylePolicy_response.** In the Rule Direction dropdown, select the option: **Server to Client.**

![](./images/DP-LAB3-00029.png)

**30.**	Click the **Match rule** action to reveal its configuration form in a pop-up window.

![](./images/DP-LAB3-00030.png)

**31.**	In the Matching Rule dropdown, select: **test-MatchingRule-All.** Then, click the **Done** button.

![](./images/DP-LAB3-00031.png)

**32.**	In the Rule section, click the **Done** button.

![](./images/DP-LAB3-00032.png)

**33.**	The new Rule should be automatically added. There should be two (2) rules. Click the **Apply Policy** button to create the style policy.

![](./images/DP-LAB3-00033.png)

**34.**	A successful message should be displayed. Click the **‘x’** button. The new Style Policy should be created. Then, click the **‘x’** button in the Configure Multi-Protocol Gateway Style Policy tab.

![](./images/DP-LAB3-00034.png)

**35.**	In the Default Backend URL field, type:

```
https://echo.free.beeceptor.com/
```
(DO NOT FOLLOW THE VALUE IN THE IMAGE BELOW)

![](./images/DP-LAB3-00035.png)

**36.**	In the TLS client type field, select the option: **Client profile.** Then, select the **‘+’** button in the TLS client profile field.

![](./images/DP-LAB3-00036.png)

**37.**	In the Name field, type: **test-TLSClient**

![](./images/DP-LAB3-00037.png)

**38.**	Scroll down to the Credentials section. Turn off **Validate server certificate.**

![](./images/DP-LAB3-00038.png)

**39.**	Click the **Apply** button in the upper section of the form.

![](./images/DP-LAB3-00039.png)

**40.**	A successful message should be displayed.

![](./images/DP-LAB3-00040.png)

**41.**	In Response type field, select the option: **PassThrough** 
(DO NOT FOLLOW THE VALUE IN THE IMAGE BELOW)
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

**51.**	In Request type field, select the option: **Non-XML**
(DO NOT FOLLOW THE VALUE IN THE IMAGE BELOW)
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

**62.**	Click on the **‘+’** button to add a new action.
(IGNORE the BOX NAMED "CONVERT" IN THE IMAGE BELOW)
![](./images/DP-LAB3-00062.png)

**63.**	In the Actions section, click on the **Transform** icon.

![](./images/DP-LAB3-00063.png)

**64.**	Click the **“Transform”** action to provide the configuration details.

![](./images/DP-LAB3-00064.png)

**65.**	Click on the “Upload Files” button.

![](./images/DP-LAB3-00065.png)

**66.**	Click the **“Drag and drop files or click to upload”** link.

![](./images/DP-LAB3-00066.png)

**67.**	Click on the **Download** Location button. Select the XSL file.
(DO NOT FOLLOW THE VALUE IN THE IMAGE BELOW)
![](./images/DP-LAB3-00067.png)

**68.**	Click on the **Upload** button.

![](./images/DP-LAB3-00068.png)

**69.**	A successful message should be displayed.

![](./images/DP-LAB3-00069.png)

**70.** Toggle the BASIC to ADVANCED. Also ensure INPUT and OUTPUT are same like IMAGE below.

<img width="986" alt="image" src="https://github.com/user-attachments/assets/e4e7987c-cf2b-43e9-951d-c22f807cbe6d" />

**71.00 ** Scroll down and Add on HTTP HEADER NAME and VALUE

<img width="993" alt="image" src="https://github.com/user-attachments/assets/e38cacc5-6975-424f-973d-7c33a9a7242e" />

**72.**	Click on **Done** button.

![](./images/DP-LAB3-00070.png)

**73.**	A successful message should be displayed.

**74.** Click on the "Apply Policy".

<img width="1043" alt="image" src="https://github.com/user-attachments/assets/1c0bab1b-33c6-4437-b085-40227db5f1fc" />


**74.**	Open a terminal inside the DP VM, run the curl command to test the service. Alternatively just use BROWSER inside the DP VM and open localhost:8000.

```
[techzone@rhel9-base ~]$ curl localhost:8000 
```

Notice you have the customised key:value HEADER.

**OPTIONAL**

You can also add same "Transform" action in "Server to Client" RULE direction to Adding another customised HEADER from Datapower to your CLIENT (i.e web browser).

**This is the end of lab 3. Congratulations!**
