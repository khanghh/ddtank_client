package entertainmentMode.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class EntertainmentInfoFrame extends BaseAlerFrame
   {
      
      public static const SUM_NUMBER:int = 20;
       
      
      private var _list:SimpleTileList;
      
      private var _items:Vector.<PropItemView>;
      
      private var _page:int = 1;
      
      private var propList:Array;
      
      public function EntertainmentInfoFrame()
      {
         propList = [];
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var prop:* = null;
         var item:* = null;
         var propBox:* = null;
         propList = ItemManager.Instance.getPropByTypeAndPro();
         var _bottom:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("entertainment.frameBottom");
         _list = ComponentFactory.Instance.creatCustomObject("entertainment.TrophyList",[5]);
         this.titleText = LanguageMgr.GetTranslation("entertainment.view.title");
         _items = new Vector.<PropItemView>();
         _list.beginChanges();
         for(i = 0; i < propList.length; )
         {
            prop = new PropInfo(propList[i]);
            item = new PropItemView(prop,true,false);
            item.propPos = 5;
            propBox = ComponentFactory.Instance.creat("asset.Entertainment.mode.propBox");
            propBox.width = 48;
            propBox.height = 48;
            item.width = 50;
            item.height = 50;
            item.addChildAt(propBox,0);
            _items.push(item);
            _list.addChild(item);
            i++;
         }
         _list.commitChanges();
         var _explanationPanel:ScrollPanel = ComponentFactory.Instance.creatComponentByStylename("entertainment.view.scrollPanel");
         _explanationPanel.setView(_list);
         addToContent(_bottom);
         addToContent(_explanationPanel);
         escEnable = true;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            hide();
         }
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function _nextClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _page = Number(_page) + 1;
         if(_page > pageSum())
         {
            _page = 1;
         }
      }
      
      private function _prevClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _page = Number(_page) - 1;
         if(_page < 1)
         {
            _page = pageSum();
         }
      }
      
      public function pageSum() : int
      {
         return 1;
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         removeEvents();
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_items != null)
         {
            for(i = 0; i < _items.length; )
            {
               ObjectUtils.disposeObject(_items[i]);
               i++;
            }
            _items = null;
         }
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
