function decode(json)
{
    return window.JSON && window.JSON.parse ? window.JSON.parse(json) : (new Function("return " + json))();
}

function getCookie(c_name)
{
    var i,x,y,ARRcookies=document.cookie.split(";");
    for (i=0;i<ARRcookies.length;i++)
    {
        x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
        y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
        x=x.replace(/^\s+|\s+$/g,"");
        if (x==c_name)
        {
           return unescape(y);
        }
    }
}

function setCookie(c_name,value,exdays)
{
   var exdate=new Date();
   exdate.setDate(exdate.getDate() + exdays);
   var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
   document.cookie=c_name + "=" + c_value;
}
function sortlist(ctrl)
{
   var savedValue=ctrl.value;
   optionsText = new Array();
   for(i=0; i<ctrl.length; i++)
   {
     optionsText[i] = ctrl.options[i].text;
   }
   optionsText.sort();
   for(i=0; i<ctrl.length; i++)
   {
      ctrl.options[i].text = optionsText[i];
      ctrl.options[i].value = optionsText[i];
   }
   ctrl.value=savedValue;
   ctrl.onfocus=null;
}
/* Salesforce object creating */
function createTrigger( session,body,output,tbl )
{
   sforce.connection.init( session, "/services/Soap/s/25.0" );

   try
   {
      var trigger = new sforce.Xml( "compileAndTestRequest" );
      trigger.checkOnly = "false";
      trigger.triggers = body;
      var arg = new sforce.internal.Parameter( "sObjects", [trigger], true );
      var queryResult = sforce.connection._invoke( "compileAndTest", [arg], true, null,
                  [{ns:'http://soap.sforce.com/2006/08/apex', prefix:null},
                   {ns:'http://soap.sforce.com/2006/08/apex', prefix:"ns1"}],
                        sforce.connection.serverUrl,
                        'http://soap.sforce.com/2006/08/apex',
                        'http://soap.sforce.com/2006/08/apex' )

                        if ( !queryResult[0].getBoolean( "success" ) )
      {
         output.innerHTML = 'Compile error: '+queryResult[0].triggers.problem + ' at line '+queryResult[0].triggers.line+' column '+ queryResult[0].triggers.column ;
         tbl.style.display='';
         return false;
      }
      tbl.style.display='none';
      return true;
   }
   catch ( exc )
   {
      output.innerHTML = 'Triggern error:' + ( exc.faultstring || exc );
      tbl.style.display='';
      return false;
   }
}
function createEmailService( session, classId, routingAddress, output, tbl )
{
   sforce.connection.init( session, '/services/Soap/u/25.0' );

   try
   {
      var serv = new sforce.SObject( "EmailServicesFunction" );
      serv.ApexClassId = classId;
      serv.FunctionName = "ETAworkforce activity";
      serv.IsActive = true;
      serv.AttachmentOption = 0;
      serv.AuthorizedSenders = "etadirect.com";
      serv.FunctionInactiveAction = 1;
      serv.OverLimitAction = 1;
      serv.AddressInactiveAction = 1;
      serv.ErrorRoutingAddress = routingAddress;
      serv.IsErrorRoutingEnabled = true;

      var queryResult = sforce.connection.create( [serv] );

      if ( queryResult[0].getBoolean( "success" ) )
      {
         tbl.style.display = 'none';
         return queryResult[0].id;
      }
      else
      {
         output.innerHTML = 'Can\'t create Email service:'+( queryResult[0].errors.fields || 'Error' ) + ':' + queryResult[0].errors.message;
         tbl.style.display = '';
      }
   }
   catch ( exc )
   {
      output.innerHTML = 'Can\'t create Email service:' + ( exc.faultstring || exc );
      tbl.style.display = '';
   }

   return null;
}

function createEmailAddress( session, serviceId, userId, output, tbl )
   {
      sforce.connection.init( session, '/services/Soap/u/25.0' );

      try
      {
         var adr = new sforce.SObject( "EmailServicesAddress" );
         adr.FunctionId = serviceId;
         adr.IsActive = true;
         adr.LocalPart = 'activity';
         adr.AuthorizedSenders = "etadirect.com";
         adr.RunAsUserId = userId;
         var queryResult = sforce.connection.create( [adr] );

         if ( queryResult[0].getBoolean( "success" ) )
         {
            tbl.style.display = 'none';
            return true;
         }
         else
         {
            output.innerHTML = 'Can\'t create Email service address:'+( queryResult[0].errors.fields || 'Error' ) + ':' + queryResult[0].errors.message;
            tbl.style.display = '';
         }
      }
      catch ( exc )
      {
         output.innerHTML = 'Can\'t create Email service address:' + ( exc.faultstring || exc );
         tbl.style.display = '';
      }

      return false;
   }
function openNewFieldWindow(ctrl,name,target)
    {
        if(name=='Task' || name=='Event')
            name='Activity';
        var id=getCookie(removeNameSpace(name));
        window.open('/p/setup/field/NewCustomFieldStageManager?entity='+(id?id:name)+'&setupid=CustomObjects',target);
    }
function removeNameSpace(name)
    {
        var first=name.indexOf('__');
        var last=name.lastIndexOf('__');
        if(first!=last)
            name=name.substring(first+2);
        return name;
    }
function getNotificationObjectId(session,objects)
    {
       var need=objects.length;
       for(var i=0;i<objects.length;++i)
       {
           objects[i]=removeNameSpace(objects[i]);
           if(getCookie(objects[i])!=null )
               --need;
       }
      if(need==0)
          return;
      sforce.connection.init( session, "/services/Soap/m/25.0" );
      var request = new sforce.Xml( "queries" );
      request.type = "CustomObject";
      var arg = new sforce.internal.Parameter( "queries", [request], true );
      var queryResult = sforce.connection._invoke( "listMetadata", [arg], true, null,
                  [{ns:'http://soap.sforce.com/2006/04/metadata', prefix:null},
                   {ns:'http://soap.sforce.com/2006/04/metadata', prefix:"met"}],
                        sforce.connection.serverUrl,
                        'http://soap.sforce.com/2006/04/metadata',
                        'http://soap.sforce.com/2006/04/metadata' )
       for(var k=0;k<queryResult.length && need!=0;++k)
       {
           var objName=removeNameSpace(queryResult[k].fullName);
           for(var i=0;i<objects.length;++i)
           {
               if(objects[i]==objName)
               {
                   --need;
                   setCookie(objects[i],queryResult[k].id.substring(0,queryResult[k].id.length-3));
               }
           }
           if(need==0)
               break;
       }
    }
    function getMetadataFields(session)
    {
      var fieldsArray=new Array();
      var request = new sforce.Xml( "queries" );
      request.type = "CustomField";
      var arg = new sforce.internal.Parameter( "queries", [request], true );
      var queryResult = sforce.connection._invoke( "listMetadata", [arg], true, null,
                  [{ns:'http://soap.sforce.com/2006/04/metadata', prefix:null},
                   {ns:'http://soap.sforce.com/2006/04/metadata', prefix:"met"}],
                        sforce.connection.serverUrl,
                        'http://soap.sforce.com/2006/04/metadata',
                        'http://soap.sforce.com/2006/04/metadata' );
       for(var k=0;k<queryResult.length;++k)
       {
//           if("objects/ETAworkforceNotification__c.object"==queryResult[k].fileName && 
//              (queryResult[k].namespacePrefix=="TOA" && queryResult[k].manageableState=="unmanaged")
              
           if("objects/TOA__ETAworkforceNotification__c.object"==queryResult[k].fileName &&                   
               (queryResult[k].namespacePrefix==undefined || queryResult[k].namespacePrefix==null 
                   || queryResult[k].namespacePrefix=="" || "TOA"!=queryResult[k].namespacePrefix)
             )
           fieldsArray.push(queryResult[k].fullName);
       }
       return fieldsArray;
    }
    function getFieldsDescribeId(session,fieldsArray)
    {
      var request = new sforce.Xml( "retrieveRequest" );
      request.unpackaged=new sforce.Xml( "unpackaged" );
      request.unpackaged.version = "26";
      request.unpackaged.types=new sforce.Xml( "types" );
      request.unpackaged.types.members=fieldsArray;
      request.unpackaged.types.name="CustomField";
      var arg = new sforce.internal.Parameter( "retrieveRequest", [request], true );
      var queryResult = sforce.connection._invoke( "retrieve", [arg], true, null,
                  [{ns:'http://soap.sforce.com/2006/04/metadata', prefix:null},
                   {ns:'http://soap.sforce.com/2006/04/metadata', prefix:"met"}],
                        sforce.connection.serverUrl,
                        'http://soap.sforce.com/2006/04/metadata',
                        'http://soap.sforce.com/2006/04/metadata' );
      if(queryResult && queryResult[0] && queryResult[0].id)
          return queryResult[0].id;
      return null;
    }
    function getFieldsDescribeResult(session,id)
    {
      for(var i=0;i<10;i++)
      {
         try
         {
            var arg = new sforce.internal.Parameter( "asyncProcessId", [id], true );
            var queryResult = sforce.connection._invoke( "checkRetrieveStatus", [arg], true, null,
                        [{ns:'http://soap.sforce.com/2006/04/metadata', prefix:null},
                         {ns:'http://soap.sforce.com/2006/04/metadata', prefix:"met"}],
                           sforce.connection.serverUrl,
                           'http://soap.sforce.com/2006/04/metadata',
                           'http://soap.sforce.com/2006/04/metadata' );
            if(queryResult && queryResult[0] && queryResult[0].zipFile && queryResult[0].zipFile!='')
                return queryResult[0].zipFile;
         }catch(ex)
         {
            if(console)console.log(ex);
         }
      }
      return null;
    }
    function getNotificationFieldsZip(session)
    {
        var step="1";
        try
        {
          sforce.connection.init( session, "/services/Soap/m/25.0" );

          var fieldsArray=getMetadataFields(session);
          step="2";
          if(fieldsArray.size==0)
              return null;
          var id=getFieldsDescribeId(session,fieldsArray);
          step="3"
          if(id==null)
              return null;
          step="4";
          return getFieldsDescribeResult(session,id);
        }catch(ex)
        {
            alert("Notification fields can't be exported/imported.Step "+step+":"+ex);
        }
    }
    function deployZippedFields(session,zippedFields)
    {
      var arg = new sforce.internal.Parameter( "ZipFile", [zippedFields], true );
      var DeployOptions = new sforce.Xml( "DeployOptions" );
      DeployOptions.ignoreWarnings=true;
      var queryResult = sforce.connection._invoke( "deploy", [arg,new sforce.internal.Parameter( "DeployOptions", [DeployOptions], true )], true, null,
                  [{ns:'http://soap.sforce.com/2006/04/metadata', prefix:null},
                   {ns:'http://soap.sforce.com/2006/04/metadata', prefix:"met"}],
                        sforce.connection.serverUrl,
                        'http://soap.sforce.com/2006/04/metadata',
                        'http://soap.sforce.com/2006/04/metadata' );
      if(queryResult && queryResult[0] && queryResult[0].id)
          return queryResult[0].id;
      return null;

    }
    function deployZippedFieldsResult(session,id)
    {
      var arg = new sforce.internal.Parameter( "asyncProcessId", [id], true );
      try
      {
      var queryResult = sforce.connection._invoke( "checkDeployStatus", [arg], true, null,
                  [{ns:'http://soap.sforce.com/2006/04/metadata', prefix:null},
                   {ns:'http://soap.sforce.com/2006/04/metadata', prefix:"met"}],
                        sforce.connection.serverUrl,
                        'http://soap.sforce.com/2006/04/metadata',
                        'http://soap.sforce.com/2006/04/metadata' );
      if(queryResult && queryResult[0])
          return queryResult[0].success;
      }catch(ex)
      {
         if(console)console.log(ex);
      }
      return null;
    }

    function importNotificationFieldsZip(session,zippedFields)
    {
        try
        {
          sforce.connection.init( session, "/services/Soap/m/25.0" );

          var id=deployZippedFields(session,zippedFields);
          if(id==null)
              return null;
          deployZippedFieldsResult(session,id);
        }catch(ex)
        {
            alert("Notification fields can't be imported:"+ex);
        }
    }


/* MENU BUILD UTILITIES */
         function getValue() {
             var linkedCtrlId=$("#theMenu").attr('linked_control');
             var ctrl=$("#Edit_"+linkedCtrlId);
             var value = ctrl.prev().children(".ui-button-text").text();
             return value;
         }
         function setValue(value,type) {
             var linkedCtrlId=$("#theMenu").attr('linked_control');
             if(linkedCtrlId=='')
                 return;
             $("#EditType_"+linkedCtrlId).children().val(type);
             var ctrl=$("#Edit_"+linkedCtrlId);
             ctrl.children().val(value?value:'(none)');
             ctrl.prev().children(".ui-button-text").text(value?value:'(none)');
         }
        function buildMenu(menuHtml) {
            var selected = 
                {select: function( event, ui ) {
                    setValue(ui.item.attr('full_name'),1);
                    ui.item.parent().focus();
                    $(this).popup("close");
                    }
                };
            $("#theMenu").html("<li><a style=\"text-align:center;padding-bottom:5px\" onclick=\"var res=prompt(\'Enter value\',getValue());"+
                               "setValue(res,2);$(\'#theMenu\').attr(\'linked_control\',\'\')\"><h1>Set constant... </h1></a></li>"+
                               "<li><a style=\"text-align:center;border-bottom: 1px solid #ECECEC;padding-bottom:5px;\" onclick=\"setValue(null,2);"+
                               "$(\'#theMenu\').attr(\'linked_control\',\'\')\"><h1>Clear</h1></a></li>"+
                              "<li><a style=\"text-align:center;border-bottom: 1px solid #ECECEC;padding-bottom:5px;\" onclick=\"setValue(\'(empty)\',3);"+
                               "$(\'#theMenu\').attr(\'linked_control\',\'\')\"><h1>Empty value</h1></a></li>"+
                               menuHtml);
            $("#theMenu").menu(selected).popup({trigger:$(".fieldButton")});
            $(".fieldButton").button( {text: true,icons: {primary: "ui-icon-circle-triangle-s"}});
        }
