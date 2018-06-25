package Indiana
{
   import Indiana.item.IndianaHistoryItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class HistoryofIndianaPanel extends Sprite implements Disposeable
   {
       
      
      private var _scroller:ScrollPanel;
      
      private var _vbox:VBox;
      
      public function HistoryofIndianaPanel()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         IndianaDataManager.instance.addEventListener("historyiteminfo",__updateItem);
      }
      
      private function removeEvent() : void
      {
         IndianaDataManager.instance.removeEventListener("historyiteminfo",__updateItem);
      }
      
      private function __updateItem(e:Event) : void
      {
         setItem();
      }
      
      private function initView() : void
      {
         _scroller = ComponentFactory.Instance.creatComponentByStylename("indiana.scroll.historypanel");
         _vbox = new VBox();
         _vbox.spacing = 0;
         addChild(_scroller);
         setItem();
      }
      
      private function setItem() : void
      {
         var item:* = null;
         var i:int = 0;
         _vbox.clearAllChild();
         var len:int = IndianaDataManager.instance.HistoryIndianaInfo.length;
         for(i = 0; i < len; )
         {
            item = new IndianaHistoryItem();
            item.setInfo(IndianaDataManager.instance.HistoryIndianaInfo[i]);
            _vbox.addChild(item);
            i++;
         }
         _scroller.setView(_vbox);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _scroller = null;
         _vbox = null;
      }
   }
}
