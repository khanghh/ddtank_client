package org.as3commons.reflect
{
   public interface IMember extends IMetadataContainer
   {
       
      
      function get name() : String;
      
      function get type() : Type;
      
      function get declaringType() : Type;
   }
}
