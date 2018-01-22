package Indiana
{
   import Indiana.item.IndianaRecodeItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class IndianaRecodePanel extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _scroller:ScrollPanel;
      
      private var _vbox:VBox;
      
      public function IndianaRecodePanel()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         IndianaDataManager.instance.addEventListener("recodeiteminfo",__recodeUpdata);
      }
      
      private function __recodeUpdata(param1:Event) : void
      {
         setItem();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.indiana.recode.bg");
         _scroller = ComponentFactory.Instance.creatComponentByStylename("indiana.scroll.recodepanel");
         _vbox = new VBox();
         _vbox.spacing = 12;
         _scroller.setView(_vbox);
         addChild(_bg);
         addChild(_scroller);
         setItem();
      }
      
      private function setItem() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = IndianaDataManager.instance.currentIndianInfo.length;
         clearItem();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new IndianaRecodeItem();
            _loc1_.info = IndianaDataManager.instance.currentIndianInfo[_loc3_];
            _vbox.addChild(_loc1_);
            _loc3_++;
         }
         _loc1_ = new IndianaRecodeItem();
         _loc1_.visible = false;
         _vbox.addChild(_loc1_);
         _scroller.invalidateViewport();
      }
      
      public function clearItem() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _vbox.clearAllChild();
         var _loc2_:int = _vbox.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_vbox.getChildAt(_loc3_) is IndianaRecodeItem)
            {
               _loc1_ = _vbox.getChildAt(_loc3_) as IndianaRecodeItem;
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
               _loc3_--;
            }
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         IndianaDataManager.instance.removeEventListener("recodeiteminfo",__recodeUpdata);
         if(_scroller)
         {
            ObjectUtils.disposeObject(_scroller);
         }
         _scroller = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         _vbox = null;
      }
   }
}
