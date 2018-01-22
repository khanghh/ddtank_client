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
         this.oriSize = new Point();
         super();
         mouseChildren = true;
         width = height = 50;
      }
      
      public function get bindClass() : String
      {
         return this._bindClass;
      }
      
      public function set bindClass(param1:String) : void
      {
         this._bindClass = param1;
      }
      
      public function init(... rest) : DisplayObject
      {
         if(this.comp)
         {
            ObjectUtils.disposeObject(this.comp);
            this.comp = null;
         }
         this.comp = ClassUtils.CreatInstance(this._bindClass,rest);
         addChild(this.comp);
         if(this._fitSize)
         {
            this.comp.width = width;
            this.comp.height = height;
         }
         return this.comp;
      }
      
      public function setChildFollowParentPosition() : void
      {
         this.comp.x = x;
         this.comp.y = y;
      }
      
      public function get comp() : DisplayObject
      {
         return this._comp;
      }
      
      public function set comp(param1:DisplayObject) : void
      {
         this._comp = param1;
      }
      
      public function set fitSize(param1:Boolean) : void
      {
         this._fitSize = param1;
      }
      
      public function get fitSize() : Boolean
      {
         return this._fitSize;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(this.comp);
      }
   }
}
