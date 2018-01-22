package org.as3commons.reflect
{
   import org.as3commons.lang.HashArray;
   
   public class MetadataContainer implements IMetadataContainer
   {
      
      private static const METADATA_NAME_PROPERTY:String = "name";
       
      
      private var _metadata:HashArray;
      
      public function MetadataContainer(param1:HashArray = null)
      {
         super();
         this._metadata = param1 == null?new HashArray(METADATA_NAME_PROPERTY,true):param1;
      }
      
      public function get metadata() : Array
      {
         return this._metadata.getArray();
      }
      
      public function addMetadata(param1:Metadata) : void
      {
         this._metadata.push(param1);
      }
      
      public function getMetadata(param1:String) : Array
      {
         var _loc2_:* = this._metadata.get(param1.toLowerCase());
         return _loc2_ is Array?_loc2_:_loc2_ != null?[_loc2_]:_loc2_;
      }
      
      public function hasMetadata(param1:String) : Boolean
      {
         return this.getMetadata(param1.toLowerCase()) != null;
      }
      
      public function hasExactMetadata(param1:Metadata) : Boolean
      {
         var _loc3_:Metadata = null;
         var _loc2_:Array = this.getMetadata(param1.name);
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.equals(param1))
            {
               return true;
            }
         }
         return false;
      }
   }
}
