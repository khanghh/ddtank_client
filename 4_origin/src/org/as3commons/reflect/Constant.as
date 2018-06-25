package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.HashArray;
   
   public class Constant extends Field
   {
       
      
      public function Constant(name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null)
      {
         super(name,type,declaringType,isStatic,applicationDomain,metadata);
      }
      
      public static function newInstance(name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null) : Constant
      {
         return Constant(AbstractMember.newInstance(Constant,name,type,declaringType,isStatic,applicationDomain,metadata));
      }
   }
}
