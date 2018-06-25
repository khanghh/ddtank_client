package yzhkof.debug
{
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import mx.utils.ObjectUtil;
   import yzhkof.util.XmlUtil;
   
   public class TextUtil
   {
       
      
      public function TextUtil()
      {
         super();
      }
      
      public static function objToTextTrace(obj:*, showFunctionReturn:Boolean = false) : String
      {
         var final_text:String = null;
         var title_text:String = null;
         var objname:String = null;
         var xml:XML = null;
         var isClass:Boolean = false;
         var accessor_xmllist:XMLList = null;
         var x:XML = null;
         var tempName:String = null;
         var ob_p:Object = null;
         var method_xmllist:XMLList = null;
         var xx:XML = null;
         try
         {
            final_text = "";
            title_text = "";
            if(obj != null && obj != undefined)
            {
               xml = describeType(getDefinitionByName(getQualifiedClassName(obj)));
               isClass = obj is Class;
               if(!isSimple(obj))
               {
                  accessor_xmllist = getAccessProperty(xml,isClass);
                  if(obj is ByteArray)
                  {
                     final_text = final_text + ("Bytes:\n" + Hex.dump(obj));
                  }
                  for each(x in accessor_xmllist)
                  {
                     try
                     {
                        if(!(obj[x.@name] is ByteArray))
                        {
                           tempName = obj[x.@name];
                           if(tempName && tempName.indexOf("object") != -1)
                           {
                              final_text = final_text + (addSpace("{" + x.@name + "} = " + getQualifiedClassName(obj[x.@name])) + "\n");
                           }
                           else
                           {
                              final_text = final_text + (addSpace("{" + x.@name + "} = " + obj[x.@name]) + "\n");
                           }
                           if(x.@name == "name")
                           {
                              objname = obj.name;
                           }
                        }
                        else
                        {
                           final_text = final_text + ("{" + x.@name + "} = " + Hex.dump(obj[x.@name]) + "\n");
                        }
                     }
                     catch(e:Error)
                     {
                        continue;
                     }
                  }
                  if(xml.@isDynamic == "true")
                  {
                     for(ob_p in obj)
                     {
                        if(!(obj[ob_p] is ByteArray))
                        {
                           final_text = final_text + (addSpace("{" + ob_p + "} = " + obj[ob_p]) + "\n");
                        }
                        else
                        {
                           final_text = final_text + ("{" + ob_p + "} = " + Hex.dump(obj[x.@name]) + "\n");
                        }
                     }
                  }
                  if(showFunctionReturn)
                  {
                     method_xmllist = getReturnOnlyMethod(xml,isClass);
                     for each(xx in method_xmllist)
                     {
                        final_text = final_text + (addSpace("[" + xx.@name + "()] : " + obj[xx.@name]()) + "\n");
                     }
                  }
                  else if(!(obj is ByteArray))
                  {
                     final_text = final_text + (addSpace("[toString()] : " + obj.toString()) + "\n");
                  }
               }
               else
               {
                  final_text = final_text + (addSpace(obj.toString()) + "\n");
               }
               title_text = "Type : " + xml.@name;
            }
            else
            {
               final_text = final_text + (obj + "\n");
            }
            if(objname)
            {
               title_text = title_text + ("(name:" + objname + ")");
            }
            title_text = title_text + "**************************\n";
            final_text = final_text + "**********************************************\n";
            final_text = title_text + final_text;
         }
         catch(e:Error)
         {
            final_text = simpleObjToTextTrace(obj);
         }
         return final_text;
      }
      
      public static function getMethod(xml:XML, isClass:Boolean = false) : XMLList
      {
         var method_xmllist:XMLList = null;
         if(!isClass)
         {
            method_xmllist = xml.factory.method;
         }
         else
         {
            method_xmllist = xml.method;
         }
         return method_xmllist;
      }
      
      public static function getReturnOnlyMethod(xml:XML, isClass:Boolean = false) : XMLList
      {
         var x:XML = null;
         var method_xmllist:XMLList = getMethod(xml,isClass);
         var return_only_method_xmllist:XMLList = new XMLList();
         for each(x in method_xmllist.(@returnType != "void"))
         {
            if(!x.hasOwnProperty("parameter"))
            {
               return_only_method_xmllist = return_only_method_xmllist + x;
            }
         }
         return return_only_method_xmllist;
      }
      
      public static function getAccessProperty(xml:XML, isClass:Boolean = false) : XMLList
      {
         var accessor_xmllist:XMLList = null;
         if(!isClass)
         {
            accessor_xmllist = xml.factory.accessor.(@access != "writeonly");
            accessor_xmllist = accessor_xmllist + xml.factory.variable;
         }
         else
         {
            accessor_xmllist = xml.accessor.(@access != "writeonly");
            accessor_xmllist = accessor_xmllist + xml.variable;
         }
         accessor_xmllist = XmlUtil.sortOnXMLList(accessor_xmllist,"@name");
         return accessor_xmllist;
      }
      
      private static function isSimple(obj:Object) : Boolean
      {
         var type:String = typeof obj;
         switch(type)
         {
            case "number":
            case "string":
            case "boolean":
               return true;
            default:
               return false;
         }
      }
      
      private static function addSpace(str:String) : String
      {
         return "\t" + str;
      }
      
      public static function simpleObjToTextTrace(obj:*) : String
      {
         var objClass:Object = null;
         var arr:Array = null;
         var i:int = 0;
         var qname:QName = null;
         var tempObj:Object = null;
         var final_text:String = "";
         var objname:String = "";
         var title_text:String = "";
         if(isSimple(obj))
         {
            final_text = final_text + (addSpace(obj) + "\n");
            title_text = "Type : " + typeof obj;
         }
         else if(obj != null && obj != undefined)
         {
            objClass = ObjectUtil.getClassInfo(obj);
            arr = objClass.properties;
            for(i = 0; i < arr.length; i++)
            {
               qname = arr[i];
               tempObj = obj[qname.localName];
               if(tempObj && String(tempObj).indexOf("object") != -1)
               {
                  final_text = final_text + (addSpace("{" + qname.localName + "} = " + getQualifiedClassName(tempObj)) + "\n");
               }
               else
               {
                  final_text = final_text + (addSpace("{" + qname.localName + "} = " + tempObj) + "\n");
               }
               if(qname.localName == "name")
               {
                  objname = obj.name;
               }
            }
            final_text = final_text + (addSpace("[toString()] : " + obj.toString()) + "\n");
            title_text = "Type : " + objClass.name;
            if(objname)
            {
               title_text = title_text + ("(name:" + objname + ")");
            }
         }
         title_text = title_text + "**************************\n";
         final_text = final_text + "**********************************************\n";
         final_text = title_text + final_text;
         return final_text;
      }
   }
}
