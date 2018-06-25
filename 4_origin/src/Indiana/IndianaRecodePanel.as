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
      
      private function __recodeUpdata(e:Event) : void
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
         var item:* = null;
         var i:int = 0;
         var len:int = IndianaDataManager.instance.currentIndianInfo.length;
         clearItem();
         for(i = 0; i < len; )
         {
            item = new IndianaRecodeItem();
            item.info = IndianaDataManager.instance.currentIndianInfo[i];
            _vbox.addChild(item);
            i++;
         }
         item = new IndianaRecodeItem();
         item.visible = false;
         _vbox.addChild(item);
         _scroller.invalidateViewport();
      }
      
      public function clearItem() : void
      {
         var i:int = 0;
         var item:* = null;
         _vbox.clearAllChild();
         var len:int = _vbox.numChildren;
         for(i = 0; i < len; )
         {
            if(_vbox.getChildAt(i) is IndianaRecodeItem)
            {
               item = _vbox.getChildAt(i) as IndianaRecodeItem;
               ObjectUtils.disposeObject(item);
               item = null;
               i--;
            }
            i++;
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
