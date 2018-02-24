package gemstone.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import ddt.manager.LanguageMgr;
   import ddt.view.SimpleItem;
   import flash.display.DisplayObject;
   import gemstone.info.GemstoneStaticInfo;
   
   public class GemstoneTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _tempData:Object;
      
      private var _fiSoulName:FilterFrameText;
      
      private var _quality:SimpleItem;
      
      private var _type:SimpleItem;
      
      private var _attack:FilterFrameText;
      
      private var _defense:FilterFrameText;
      
      private var _agility:FilterFrameText;
      
      private var _luck:FilterFrameText;
      
      private var _grade1:FilterFrameText;
      
      private var _grade2:FilterFrameText;
      
      private var _grade3:FilterFrameText;
      
      private var _forever:FilterFrameText;
      
      private var _displayList:Vector.<DisplayObject>;
      
      public function GemstoneTip(){super();}
      
      override protected function addChildren() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      private function clear() : void{}
      
      private function updateView() : void{}
      
      override public function get tipData() : Object{return null;}
      
      override protected function init() : void{}
      
      private function initPos() : void{}
   }
}
