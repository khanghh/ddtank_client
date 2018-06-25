package consortion.view.club
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class ClubRecordList extends Sprite implements Disposeable
   {
      
      public static const INVITE:int = 1;
      
      public static const APPLY:int = 2;
       
      
      private var _items:Vector.<ClubRecordItem>;
      
      private var _panel:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _data;
      
      public function ClubRecordList()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _vbox = ComponentFactory.Instance.creatComponentByStylename("club.recordList.vbox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("club.recordList.panel");
         _panel.setView(_vbox);
         addChild(_panel);
      }
      
      public function setData(data:Object, type:int) : void
      {
         var i:int = 0;
         var item:* = null;
         if(_data == data)
         {
            return;
         }
         clearItem();
         _items = new Vector.<ClubRecordItem>();
         if(data && data.length > 0)
         {
            for(i = 0; i < data.length; )
            {
               item = new ClubRecordItem(type);
               item.info = data[i];
               _items.push(item);
               _vbox.addChild(item);
               i++;
            }
         }
         _panel.invalidateViewport();
      }
      
      private function clearItem() : void
      {
         var len:int = 0;
         var i:int = 0;
         if(_items && _items.length > 0)
         {
            len = _items.length;
            for(i = 0; i < len; )
            {
               _items[i].dispose();
               _items[i] = null;
               i++;
            }
         }
         _items = null;
      }
      
      public function dispose() : void
      {
         clearItem();
         ObjectUtils.disposeAllChildren(this);
         _vbox = null;
         _panel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
