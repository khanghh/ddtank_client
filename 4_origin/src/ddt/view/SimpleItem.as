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
      
      public function set backStyle(stylename:String) : void
      {
         if(stylename == _backStyle)
         {
            return;
         }
         _backStyle = stylename;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = ComponentFactory.Instance.creat(_backStyle);
         onPropertiesChanged("backStyle");
      }
      
      public function set foreStyle(stylename:String) : void
      {
         if(stylename == _foreStyle)
         {
            return;
         }
         _foreStyle = stylename;
         clearObject();
         _foreLinks = ComponentFactory.parasArgs(stylename);
         onPropertiesChanged("foreStyle");
      }
      
      private function clearObject() : void
      {
         var i:int = 0;
         for(i = 0; i < _foreLinks.length; )
         {
            if(_foreLinks[i])
            {
               ObjectUtils.disposeObject(_foreLinks[i]);
            }
            i++;
         }
      }
      
      private function createObject() : void
      {
         var i:int = 0;
         var dp:* = null;
         for(i = 0; i < _foreLinks.length; )
         {
            dp = ComponentFactory.Instance.creat(_foreLinks[i]);
            _fore.push(dp);
            i++;
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
         var i:int = 0;
         super.addChildren();
         if(_back)
         {
            addChild(_back);
         }
         i = 0;
         while(i < _fore.length)
         {
            addChild(_fore[i]);
            i++;
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
         var i:int = 0;
         ObjectUtils.disposeObject(_back);
         _back = null;
         for(i = 0; i < _fore.length; )
         {
            ObjectUtils.disposeObject(_fore[i]);
            _fore[i] = null;
            i++;
         }
         _foreLinks = null;
         super.dispose();
      }
   }
}
