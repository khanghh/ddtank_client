package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.HashArray;
   
   public class Variable extends Field
   {
       
      
      public function Variable(name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null)
      {
         super(name,type,declaringType,isStatic,applicationDomain,metadata);
      }
      
      public static function newInstance(name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null) : Variable
      {
         return Variable(AbstractMember.newInstance(Variable,name,type,declaringType,isStatic,applicationDomain,metadata));
      }
   }
}
