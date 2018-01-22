package Indiana.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class IndianaShowBuyCodeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _scroller:ScrollPanel;
      
      private var _titleTxt:GradientBitmapText;
      
      private var _title1Txt:GradientBitmapText;
      
      private var _beginNum:Array;
      
      private var _list:SimpleTileList;
      
      private var _closeBtn:BaseButton;
      
      private var _titletimes:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _rightBtn:BaseButton;
      
      private var _leftBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _totlePage:int;
      
      private var _currentPage:int = 1;
      
      private var timesarr:Array;
      
      public function IndianaShowBuyCodeView(param1:Array)
      {
         timesarr = [];
         super();
         _beginNum = param1;
         initView();
         initEvent();
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:int = _beginNum.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = _beginNum[_loc6_].split("|")[0];
            _loc1_ = _beginNum[_loc6_].split("|")[1];
            _loc3_ = _loc3_ + _loc1_;
            _loc5_ = 0;
            while(_loc5_ < _loc1_)
            {
               timesarr.push((_loc7_ + _loc5_).toString());
               _loc5_++;
            }
            _loc6_++;
         }
         _totlePage = Math.ceil(_loc3_ / 15);
         _pageTxt.text = _currentPage + "/" + _totlePage;
         setPage(_currentPage);
         _titletimes.text = _loc3_.toString();
         _title1Txt.x = _titletimes.x + _titletimes.textWidth + 8;
         _scroller.setView(_content);
      }
      
      private function setPage(param1:int) : void
      {
         var _loc5_:* = 0;
         var _loc6_:int = (param1 - 1) * 15;
         var _loc4_:int = _loc6_ + 15;
         var _loc3_:Array = [];
         var _loc2_:int = 0;
         _pageTxt.text = _currentPage + "/" + _totlePage;
         _loc5_ = _loc6_;
         while(_loc5_ < _loc4_)
         {
            if(_loc5_ < timesarr.length)
            {
               _loc2_++;
               if(_loc2_ % 5 == 0)
               {
                  _loc3_.push(timesarr[_loc5_] + "\n");
               }
               else
               {
                  _loc3_.push(timesarr[_loc5_] + "  ");
               }
            }
            _loc5_++;
         }
         _content.text = _loc3_.join("");
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__clickHandler);
         _rightBtn.addEventListener("click",__rightClickHandler);
         _leftBtn.addEventListener("click",__leftClickHandler);
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__clickHandler);
         _rightBtn.removeEventListener("click",__rightClickHandler);
         _leftBtn.removeEventListener("click",__leftClickHandler);
      }
      
      private function __rightClickHandler(param1:MouseEvent) : void
      {
         if(_currentPage < _totlePage)
         {
            _currentPage = Number(_currentPage) + 1;
         }
         else
         {
            _currentPage = 1;
         }
         setPage(_currentPage);
      }
      
      private function __leftClickHandler(param1:MouseEvent) : void
      {
         if(_currentPage > 1)
         {
            _currentPage = Number(_currentPage) - 1;
         }
         else
         {
            _currentPage = _totlePage;
         }
         setPage(_currentPage);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.buycode.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("indiana.buycode.Title");
         _titleTxt.setText(LanguageMgr.GetTranslation("Indiana.has.join.countI"));
         _title1Txt = ComponentFactory.Instance.creatComponentByStylename("indiana.buycode.Title");
         _title1Txt.setText(LanguageMgr.GetTranslation("Indiana.has.join.countII"));
         _scroller = ComponentFactory.Instance.creatComponentByStylename("indiana.scroll.buycodepanel");
         _titletimes = ComponentFactory.Instance.creatComponentByStylename("indiana.buytitleNum.Txt");
         PositionUtils.setPos(_titletimes,"indiana.buy.title.times.pos");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("indiana.but.closebtn");
         _content = ComponentFactory.Instance.creatComponentByStylename("indiana.buycontent.Txt");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("indiana.buycode.right");
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("indiana.buycode.left");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("indiana.buycontent.Txt");
         var _loc1_:TextFormat = _pageTxt.defaultTextFormat;
         _loc1_.align = "center";
         _pageTxt.defaultTextFormat = _loc1_;
         _pageTxt.autoSize = "none";
         _pageTxt.width = 60;
         _pageTxt.height = 20;
         PositionUtils.setPos(_pageTxt,"indiana.buycode.page.pos");
         _pageTxt.text = "0/0";
         _list = new SimpleTileList(5);
         _list.hSpace = 10;
         _list.vSpace = 10;
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_title1Txt);
         addChild(_scroller);
         addChild(_closeBtn);
         addChild(_titletimes);
         addChild(_rightBtn);
         addChild(_leftBtn);
         addChild(_pageTxt);
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _titleTxt = null;
         _title1Txt = null;
         _scroller = null;
         _list = null;
         _closeBtn = null;
         _beginNum = null;
         _titletimes = null;
      }
   }
}
