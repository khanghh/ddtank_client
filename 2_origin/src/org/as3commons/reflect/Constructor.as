package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   
   public class Constructor
   {
       
      
      protected var _parameters:Array;
      
      private var _applicationDomain:ApplicationDomain;
      
      private var _declaringType:String;
      
      public function Constructor(declaringType:String, applicationDomain:ApplicationDomain, parameters:Array = null)
      {
         this._parameters = [];
         super();
         if(parameters != null)
         {
            this._parameters = parameters;
         }
         this._declaringType = declaringType;
         this._applicationDomain = applicationDomain;
      }
      
      public function get parameters() : Array
      {
         var param:BaseParameter = null;
         var result:Array = [];
         var len:int = this._parameters.length;
         for(var i:int = 0; i < len; i++)
         {
            param = this._parameters[i];
            result[result.length] = new Parameter(param,i);
         }
         return result;
      }
      
      public function get declaringType() : Type
      {
         return Type.forName(this._declaringType,this._applicationDomain);
      }
      
      public function hasNoArguments() : Boolean
      {
         return this._parameters.length == 0?true:false;
      }
   }
}
