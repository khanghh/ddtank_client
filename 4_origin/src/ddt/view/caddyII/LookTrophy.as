package ddt.view.caddyII
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class LookTrophy extends Frame
   {
      
      public static const SUM_NUMBER:int = 20;
       
      
      private var _list:SimpleTileList;
      
      private var _items:Vector.<BagCell>;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _boxTempIDList:Vector.<InventoryItemInfo>;
      
      private var _page:int = 1;
      
      public function LookTrophy()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("caddy.TrophyBGI");
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.caddy.lookFont");
         _list = ComponentFactory.Instance.creatCustomObject("caddy.TrophyList",[5]);
         var _loc1_:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("caddy.PageCountBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.pageTxt");
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.prevBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.nextBtn");
         _items = new Vector.<BagCell>();
         _list.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < 20)
         {
            _loc3_ = new BagCell(_loc5_);
            _items.push(_loc3_);
            _list.addChild(_loc3_);
            _loc5_++;
         }
         _list.commitChanges();
         addToContent(_loc4_);
         addToContent(_loc1_);
         addToContent(_loc2_);
         addToContent(_list);
         addToContent(_pageTxt);
         addToContent(_prevBtn);
         addToContent(_nextBtn);
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("tank.view.caddy.lookTrophy");
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         _prevBtn.addEventListener("click",_prevClick);
         _nextBtn.addEventListener("click",_nextClick);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         if(_prevBtn)
         {
            _prevBtn.removeEventListener("click",_prevClick);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",_nextClick);
         }
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            hide();
         }
      }
      
      private function _nextClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         page = Number(page) + 1;
         if(page > pageSum())
         {
            page = 1;
         }
         fillPage();
      }
      
      private function _prevClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         page = Number(page) - 1;
         if(page < 1)
         {
            page = pageSum();
         }
         fillPage();
      }
      
      private function fillPage() : void
      {
         var _loc3_:* = 0;
         var _loc4_:int = (page - 1) * 20;
         var _loc2_:int = page * 20;
         var _loc1_:int = 0;
         _loc3_ = _loc4_;
         while(_loc3_ < _loc2_)
         {
            if(_loc1_ < _items.length && _loc3_ < _boxTempIDList.length)
            {
               _items[_loc1_].info = _boxTempIDList[_loc3_];
            }
            else
            {
               _items[_loc1_].info = null;
            }
            _loc3_++;
            _loc1_++;
            _loc1_;
         }
      }
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         ItemManager.fill(_loc2_);
         return _loc2_;
      }
      
      public function set page(param1:int) : void
      {
         _page = param1;
         _pageTxt.text = _page + "/" + pageSum();
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      public function pageSum() : int
      {
         var _loc1_:int = Math.ceil(_boxTempIDList.length / 20);
         return _loc1_ > 0?_loc1_:1;
      }
      
      public function show(param1:Vector.<InventoryItemInfo>) : void
      {
         _boxTempIDList = param1;
         page = 1;
         fillPage();
         LayerManager.Instance.addToLayer(this,2,false,2);
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
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
         if(_prevBtn)
         {
            ObjectUtils.disposeObject(_prevBtn);
         }
         _prevBtn = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
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
         _boxTempIDList = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
