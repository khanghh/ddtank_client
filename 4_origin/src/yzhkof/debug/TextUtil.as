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
      
      public static function objToTextTrace(param1:*, param2:Boolean = false) : String
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
         var obj:* = param1;
         var showFunctionReturn:Boolean = param2;
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
      
      public static function getMethod(param1:XML, param2:Boolean = false) : XMLList
      {
         var _loc3_:XMLList = null;
         if(!param2)
         {
            _loc3_ = param1.factory.method;
         }
         else
         {
            _loc3_ = param1.method;
         }
         return _loc3_;
      }
      
      public static function getReturnOnlyMethod(param1:XML, param2:Boolean = false) : XMLList
      {
         var x:XML = null;
         var xml:XML = param1;
         var isClass:Boolean = param2;
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
      
      public static function getAccessProperty(param1:XML, param2:Boolean = false) : XMLList
      {
         var accessor_xmllist:XMLList = null;
         var xml:XML = param1;
         var isClass:Boolean = param2;
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
      
      private static function isSimple(param1:Object) : Boolean
      {
         var _loc2_:String = typeof param1;
         switch(_loc2_)
         {
            case "number":
            case "string":
            case "boolean":
               return true;
            default:
               return false;
         }
      }
      
      private static function addSpace(param1:String) : String
      {
         return "\t" + param1;
      }
      
      public static function simpleObjToTextTrace(param1:*) : String
      {
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:QName = null;
         var _loc9_:Object = null;
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = "";
         if(isSimple(param1))
         {
            _loc2_ = _loc2_ + (addSpace(param1) + "\n");
            _loc4_ = "Type : " + typeof param1;
         }
         else if(param1 != null && param1 != undefined)
         {
            _loc5_ = ObjectUtil.getClassInfo(param1);
            _loc6_ = _loc5_.properties;
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc8_ = _loc6_[_loc7_];
               _loc9_ = param1[_loc8_.localName];
               if(_loc9_ && String(_loc9_).indexOf("object") != -1)
               {
                  _loc2_ = _loc2_ + (addSpace("{" + _loc8_.localName + "} = " + getQualifiedClassName(_loc9_)) + "\n");
               }
               else
               {
                  _loc2_ = _loc2_ + (addSpace("{" + _loc8_.localName + "} = " + _loc9_) + "\n");
               }
               if(_loc8_.localName == "name")
               {
                  _loc3_ = param1.name;
               }
               _loc7_++;
            }
            _loc2_ = _loc2_ + (addSpace("[toString()] : " + param1.toString()) + "\n");
            _loc4_ = "Type : " + _loc5_.name;
            if(_loc3_)
            {
               _loc4_ = _loc4_ + ("(name:" + _loc3_ + ")");
            }
         }
         _loc4_ = _loc4_ + "**************************\n";
         _loc2_ = _loc2_ + "**********************************************\n";
         _loc2_ = _loc4_ + _loc2_;
         return _loc2_;
      }
   }
}
