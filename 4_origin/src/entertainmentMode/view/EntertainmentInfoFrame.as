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
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         propList = ItemManager.Instance.getPropByTypeAndPro();
         var _loc1_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("entertainment.frameBottom");
         _list = ComponentFactory.Instance.creatCustomObject("entertainment.TrophyList",[5]);
         this.titleText = LanguageMgr.GetTranslation("entertainment.view.title");
         _items = new Vector.<PropItemView>();
         _list.beginChanges();
         _loc6_ = 0;
         while(_loc6_ < propList.length)
         {
            _loc3_ = new PropInfo(propList[_loc6_]);
            _loc2_ = new PropItemView(_loc3_,true,false);
            _loc2_.propPos = 5;
            _loc4_ = ComponentFactory.Instance.creat("asset.Entertainment.mode.propBox");
            _loc4_.width = 48;
            _loc4_.height = 48;
            _loc2_.width = 50;
            _loc2_.height = 50;
            _loc2_.addChildAt(_loc4_,0);
            _items.push(_loc2_);
            _list.addChild(_loc2_);
            _loc6_++;
         }
         _list.commitChanges();
         var _loc5_:ScrollPanel = ComponentFactory.Instance.creatComponentByStylename("entertainment.view.scrollPanel");
         _loc5_.setView(_list);
         addToContent(_loc1_);
         addToContent(_loc5_);
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
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
      
      private function _nextClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _page = Number(_page) + 1;
         if(_page > pageSum())
         {
            _page = 1;
         }
      }
      
      private function _prevClick(param1:MouseEvent) : void
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
         var _loc1_:int = 0;
         removeEvents();
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_items != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _items.length)
            {
               ObjectUtils.disposeObject(_items[_loc1_]);
               _loc1_++;
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
