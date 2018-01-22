package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class SimpleItem extends Component
   {
      
      public static const P_backStyle:String = "backStyle";
      
      public static const P_foreStyle:String = "foreStyle";
       
      
      private var _backStyle:String;
      
      private var _foreStyle:String;
      
      private var _back:DisplayObject;
      
      private var _fore:Vector.<DisplayObject>;
      
      private var _foreLinks:Array;
      
      public function SimpleItem()
      {
         super();
      }
      
      override protected function init() : void
      {
         _fore = new Vector.<DisplayObject>();
         _foreLinks = [];
         super.init();
      }
      
      public function set backStyle(param1:String) : void
      {
         if(param1 == _backStyle)
         {
            return;
         }
         _backStyle = param1;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = ComponentFactory.Instance.creat(_backStyle);
         onPropertiesChanged("backStyle");
      }
      
      public function set foreStyle(param1:String) : void
      {
         if(param1 == _foreStyle)
         {
            return;
         }
         _foreStyle = param1;
         clearObject();
         _foreLinks = ComponentFactory.parasArgs(param1);
         onPropertiesChanged("foreStyle");
      }
      
      private function clearObject() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _foreLinks.length)
         {
            if(_foreLinks[_loc1_])
            {
               ObjectUtils.disposeObject(_foreLinks[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      private function createObject() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _foreLinks.length)
         {
            _loc1_ = ComponentFactory.Instance.creat(_foreLinks[_loc2_]);
            _fore.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function get foreItems() : Vector.<DisplayObject>
      {
         return _fore;
      }
      
      public function get backItem() : DisplayObject
      {
         return _back;
      }
      
      override protected function addChildren() : void
      {
         var _loc1_:int = 0;
         super.addChildren();
         if(_back)
         {
            addChild(_back);
         }
         _loc1_ = 0;
         while(_loc1_ < _fore.length)
         {
            addChild(_fore[_loc1_]);
            _loc1_++;
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["backStyle"])
         {
            if(_back && (_back.width > 0 || _back.height > 0))
            {
               _width = _back.width;
               _height = _back.height;
            }
         }
         if(_changedPropeties["foreStyle"])
         {
            createObject();
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         ObjectUtils.disposeObject(_back);
         _back = null;
         _loc1_ = 0;
         while(_loc1_ < _fore.length)
         {
            ObjectUtils.disposeObject(_fore[_loc1_]);
            _fore[_loc1_] = null;
            _loc1_++;
         }
         _foreLinks = null;
         super.dispose();
      }
   }
}
