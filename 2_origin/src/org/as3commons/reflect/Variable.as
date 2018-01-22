package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.HashArray;
   
   public class Variable extends Field
   {
       
      
      public function Variable(param1:String, param2:String, param3:String, param4:Boolean, param5:ApplicationDomain, param6:HashArray = null)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
      
      public static function newInstance(param1:String, param2:String, param3:String, param4:Boolean, param5:ApplicationDomain, param6:HashArray = null) : Variable
      {
         return Variable(AbstractMember.newInstance(Variable,param1,param2,param3,param4,param5,param6));
      }
   }
}
