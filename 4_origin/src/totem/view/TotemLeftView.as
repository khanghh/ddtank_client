package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   
   public class TotemLeftView extends Sprite implements Disposeable
   {
       
      
      private var _windowBg:Bitmap;
      
      private var _pageBg:Bitmap;
      
      private var _pageTxtBg:Bitmap;
      
      private var _windowView:TotemLeftWindowView;
      
      private var _firstBtn:SimpleBitmapButton;
      
      private var _forwardBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _lastBtn:SimpleBitmapButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      public function TotemLeftView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _windowBg = ComponentFactory.Instance.creatBitmap("asset.totem.leftView.windowBg");
         _pageBg = ComponentFactory.Instance.creatBitmap("asset.totem.leftView.pageBg");
         _pageTxtBg = ComponentFactory.Instance.creatBitmap("asset.totem.leftview.pageTxtBg");
         _windowView = ComponentFactory.Instance.creatCustomObject("totemLeftWindowView");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("totem.leftView.page.firstBtn");
         _forwardBtn = ComponentFactory.Instance.creatComponentByStylename("totem.leftView.page.forwardBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("totem.leftView.page.nextBtn");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("totem.leftView.page.lastBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("totem.leftView.pageTxt");
         var _loc1_:TotemDataVo = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
         if(!_loc1_)
         {
            _currentPage = 5;
         }
         else
         {
            _currentPage = _loc1_.Page;
         }
         showPage();
         addChild(_windowBg);
         addChild(_pageBg);
         addChild(_pageTxtBg);
         addChild(_windowView);
         addChild(_firstBtn);
         addChild(_forwardBtn);
         addChild(_nextBtn);
         addChild(_lastBtn);
         addChild(_pageTxt);
      }
      
      private function initEvent() : void
      {
         _firstBtn.addEventListener("click",changePage);
         _forwardBtn.addEventListener("click",changePage);
         _nextBtn.addEventListener("click",changePage);
         _lastBtn.addEventListener("click",changePage);
      }
      
      private function changePage(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc3_:* = _loc2_;
         if(_firstBtn !== _loc3_)
         {
            if(_forwardBtn !== _loc3_)
            {
               if(_nextBtn !== _loc3_)
               {
                  if(_lastBtn === _loc3_)
                  {
                     _currentPage = _totalPage;
                  }
               }
               else
               {
                  _currentPage = Number(_currentPage) + 1;
                  if(_currentPage > _totalPage)
                  {
                     _currentPage = _totalPage;
                  }
               }
            }
            else
            {
               _currentPage = Number(_currentPage) - 1;
               if(_currentPage < 1)
               {
                  _currentPage = 1;
               }
            }
         }
         else
         {
            _currentPage = 1;
         }
         showPage();
      }
      
      public function refreshView(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1)
         {
            _loc3_ = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
            if(_loc3_ && _loc3_.Page != 1 && _loc3_.Layers == 1 && _loc3_.Location == 1)
            {
               _windowView.refreshView(_loc3_,openSuccessAutoNextPage);
            }
            else
            {
               _windowView.refreshView(_loc3_);
               refreshPageBtn();
            }
         }
         else
         {
            _loc2_ = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
            _windowView.openFailHandler(_loc2_);
         }
      }
      
      private function openSuccessAutoNextPage() : void
      {
         _currentPage = Number(_currentPage) + 1;
         showPage();
      }
      
      private function refreshPageBtn() : void
      {
         var _loc1_:int = TotemManager.instance.getTotemPointLevel(PlayerManager.Instance.Self.totemId);
         _totalPage = _loc1_ / 70 + 1;
         _totalPage = _totalPage > 5?5:_totalPage;
         if(_currentPage == _totalPage)
         {
            _nextBtn.enable = false;
            _lastBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
            _lastBtn.enable = true;
         }
         if(_currentPage == 1)
         {
            _firstBtn.enable = false;
            _forwardBtn.enable = false;
         }
         else
         {
            _firstBtn.enable = true;
            _forwardBtn.enable = true;
         }
      }
      
      private function showPage() : void
      {
         refreshPageBtn();
         _pageTxt.text = _currentPage.toString();
         _windowView.show(_currentPage,TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId),true);
      }
      
      private function removeEvent() : void
      {
         _firstBtn.removeEventListener("click",changePage);
         _forwardBtn.removeEventListener("click",changePage);
         _nextBtn.removeEventListener("click",changePage);
         _lastBtn.removeEventListener("click",changePage);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _windowBg = null;
         _pageBg = null;
         _pageTxtBg = null;
         _windowView = null;
         _firstBtn = null;
         _forwardBtn = null;
         _nextBtn = null;
         _lastBtn = null;
         _pageTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
