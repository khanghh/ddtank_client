package cardSystem.view.cardCollect
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CollectTurnPage extends Sprite implements Disposeable
   {
       
      
      private var _backGround:MovieImage;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageText:FilterFrameText;
      
      private var _maxPage:int;
      
      private var _presentPage:int;
      
      public function CollectTurnPage()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set maxPage(value:int) : void
      {
         _maxPage = value;
      }
      
      public function set page(value:int) : void
      {
         if(_presentPage == value)
         {
            return;
         }
         _presentPage = value;
         _pageText.text = _presentPage + "/" + _maxPage;
         dispatchEvent(new Event("change"));
      }
      
      public function get page() : int
      {
         return _presentPage;
      }
      
      private function initView() : void
      {
         _backGround = ComponentFactory.Instance.creatComponentByStylename("asset.turnPage.bg");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtCardsList.PageCountBg");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("TurnPage.prePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("TurnPage.nextPageBtn");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("TurnPage.pageText");
         addChild(_backGround);
         addChild(_pageBg);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageText);
      }
      
      private function initEvent() : void
      {
         _preBtn.addEventListener("click",__prePage);
         _nextBtn.addEventListener("click",__nextPage);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",__prePage);
         _nextBtn.removeEventListener("click",__nextPage);
      }
      
      protected function __prePage(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(page <= 1)
         {
            page = _maxPage;
         }
         else
         {
            page = Number(page) - 1;
         }
      }
      
      protected function __nextPage(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(page >= _maxPage)
         {
            page = 1;
         }
         else
         {
            page = Number(page) + 1;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_backGround)
         {
            ObjectUtils.disposeObject(_backGround);
         }
         _backGround = null;
         if(_pageBg)
         {
            ObjectUtils.disposeObject(_pageBg);
         }
         _pageBg = null;
         if(_preBtn)
         {
            ObjectUtils.disposeObject(_preBtn);
         }
         _preBtn = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_pageText)
         {
            ObjectUtils.disposeObject(_pageText);
         }
         _pageText = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
