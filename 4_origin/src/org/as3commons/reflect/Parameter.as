package org.as3commons.reflect
{
   public class Parameter
   {
       
      
      private var _base:BaseParameter;
      
      private var _index:int;
      
      public function Parameter(param1:BaseParameter, param2:int)
      {
         super();
         this._base = param1;
         this._index = param2;
      }
      
      public function get isOptional() : Boolean
      {
         return this._base.isOptional;
      }
      
      public function get type() : Type
      {
         return this._base.type;
      }
      
      public function get index() : int
      {
         return this._index;
      }
   }
}
