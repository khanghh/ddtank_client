package morn.core.components
{
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class ProxyItem extends Component
   {
       
      
      private var _bindClass:String;
      
      private var _comp:DisplayObject;
      
      private var _param:Object;
      
      private var _cls:Class;
      
      private var _fitSize:Boolean;
      
      private var oriSize:Point;
      
      public function ProxyItem(){super();}
      
      public function get bindClass() : String{return null;}
      
      public function set bindClass(param1:String) : void{}
      
      public function init(... rest) : DisplayObject{return null;}
      
      public function setChildFollowParentPosition() : void{}
      
      public function get comp() : DisplayObject{return null;}
      
      public function set comp(param1:DisplayObject) : void{}
      
      public function set fitSize(param1:Boolean) : void{}
      
      public function get fitSize() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
