package org.as3commons.reflect
{
   import org.as3commons.lang.HashArray;
   
   public class MetadataContainer implements IMetadataContainer
   {
      
      private static const METADATA_NAME_PROPERTY:String = "name";
       
      
      private var _metadata:HashArray;
      
      public function MetadataContainer(metadata:HashArray = null)
      {
         super();
         this._metadata = metadata == null?new HashArray(METADATA_NAME_PROPERTY,true):metadata;
      }
      
      public function get metadata() : Array
      {
         return this._metadata.getArray();
      }
      
      public function addMetadata(metadata:Metadata) : void
      {
         this._metadata.push(metadata);
      }
      
      public function getMetadata(key:String) : Array
      {
         var result:* = this._metadata.get(key.toLowerCase());
         return result is Array?result:result != null?[result]:result;
      }
      
      public function hasMetadata(key:String) : Boolean
      {
         return this.getMetadata(key.toLowerCase()) != null;
      }
      
      public function hasExactMetadata(otherMetadata:Metadata) : Boolean
      {
         var metadata:Metadata = null;
         var metadatas:Array = this.getMetadata(otherMetadata.name);
         for each(metadata in metadatas)
         {
            if(metadata.equals(otherMetadata))
            {
               return true;
            }
         }
         return false;
      }
   }
}
