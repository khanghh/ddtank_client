package org.as3commons.reflect
{
   public class Parameter
   {
       
      
      private var _base:BaseParameter;
      
      private var _index:int;
      
      public function Parameter(base:BaseParameter, index:int)
      {
         super();
         this._base = base;
         this._index = index;
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
