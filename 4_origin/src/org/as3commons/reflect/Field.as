package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   import org.as3commons.lang.HashArray;
   
   public class Field extends AbstractMember
   {
       
      
      public function Field(name:String, type:String, declaringType:String, isStatic:Boolean, applicationDomain:ApplicationDomain, metadata:HashArray = null)
      {
         super(name,type,declaringType,isStatic,applicationDomain,metadata);
      }
      
      public function getValue(target:* = null) : *
      {
         if(!target)
         {
            target = declaringType.clazz;
         }
         return target[name];
      }
   }
}
