package org.as3commons.reflect{   import org.as3commons.lang.HashArray;      public class MetadataContainer implements IMetadataContainer   {            private static const METADATA_NAME_PROPERTY:String = "name";                   private var _metadata:HashArray;            public function MetadataContainer(metadata:HashArray = null) { super(); }
            public function get metadata() : Array { return null; }
            public function addMetadata(metadata:Metadata) : void { }
            public function getMetadata(key:String) : Array { return null; }
            public function hasMetadata(key:String) : Boolean { return false; }
            public function hasExactMetadata(otherMetadata:Metadata) : Boolean { return false; }
   }}