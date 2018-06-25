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
      
      public function ProxyItem()
      {
         oriSize = new Point();
         super();
         mouseChildren = true;
         height = 50;
         width = 50;
      }
      
      public function get bindClass() : String
      {
         return _bindClass;
      }
      
      public function set bindClass(value:String) : void
      {
         _bindClass = value;
      }
      
      public function init(... args) : DisplayObject
      {
         if(comp)
         {
            ObjectUtils.disposeObject(comp);
            comp = null;
         }
         comp = ClassUtils.CreatInstance(_bindClass,args);
         addChild(comp);
         if(_fitSize)
         {
            comp.width = width;
            comp.height = height;
         }
         return comp;
      }
      
      public function setChildFollowParentPosition() : void
      {
         comp.x = x;
         comp.y = y;
      }
      
      public function get comp() : DisplayObject
      {
         return _comp;
      }
      
      public function set comp(value:DisplayObject) : void
      {
         _comp = value;
      }
      
      public function set fitSize(value:Boolean) : void
      {
         _fitSize = value;
      }
      
      public function get fitSize() : Boolean
      {
         return _fitSize;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(comp);
      }
   }
}
