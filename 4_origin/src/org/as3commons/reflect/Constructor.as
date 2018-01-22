package org.as3commons.reflect
{
   import flash.system.ApplicationDomain;
   
   public class Constructor
   {
       
      
      protected var _parameters:Array;
      
      private var _applicationDomain:ApplicationDomain;
      
      private var _declaringType:String;
      
      public function Constructor(param1:String, param2:ApplicationDomain, param3:Array = null)
      {
         this._parameters = [];
         super();
         if(param3 != null)
         {
            this._parameters = param3;
         }
         this._declaringType = param1;
         this._applicationDomain = param2;
      }
      
      public function get parameters() : Array
      {
         var _loc4_:BaseParameter = null;
         var _loc1_:Array = [];
         var _loc2_:int = this._parameters.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._parameters[_loc3_];
            _loc1_[_loc1_.length] = new Parameter(_loc4_,_loc3_);
            _loc3_++;
         }
         return _loc1_;
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
