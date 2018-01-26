package org.as3commons.reflect
{
   import org.as3commons.lang.HashArray;
   
   public class MetadataContainer implements IMetadataContainer
   {
      
      private static const METADATA_NAME_PROPERTY:String = "name";
       
      
      private var _metadata:HashArray;
      
      public function MetadataContainer(param1:HashArray = null){super();}
      
      public function get metadata() : Array{return null;}
      
      public function addMetadata(param1:Metadata) : void{}
      
      public function getMetadata(param1:String) : Array{return null;}
      
      public function hasMetadata(param1:String) : Boolean{return false;}
      
      public function hasExactMetadata(param1:Metadata) : Boolean{return false;}
   }
}
