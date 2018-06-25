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
      
      public function IndianaShowBuyCodeView(beginNum:Array)
      {
         timesarr = [];
         super();
         _beginNum = beginNum;
         initView();
         initEvent();
         initItem();
      }
      
      private function initItem() : void
      {
         var time:int = 0;
         var begin:int = 0;
         var totle:int = 0;
         var i:int = 0;
         var str:* = null;
         var j:int = 0;
         var len:int = _beginNum.length;
         for(i = 0; i < len; )
         {
            begin = _beginNum[i].split("|")[0];
            time = _beginNum[i].split("|")[1];
            totle = totle + time;
            for(j = 0; j < time; )
            {
               timesarr.push((begin + j).toString());
               j++;
            }
            i++;
         }
         _totlePage = Math.ceil(totle / 15);
         _pageTxt.text = _currentPage + "/" + _totlePage;
         setPage(_currentPage);
         _titletimes.text = totle.toString();
         _title1Txt.x = _titletimes.x + _titletimes.textWidth + 8;
         _scroller.setView(_content);
      }
      
      private function setPage(page:int) : void
      {
         var i:* = 0;
         var begin:int = (page - 1) * 15;
         var len:int = begin + 15;
         var temp:Array = [];
         var index:int = 0;
         _pageTxt.text = _currentPage + "/" + _totlePage;
         for(i = begin; i < len; )
         {
            if(i < timesarr.length)
            {
               index++;
               if(index % 5 == 0)
               {
                  temp.push(timesarr[i] + "\n");
               }
               else
               {
                  temp.push(timesarr[i] + "  ");
               }
            }
            i++;
         }
         _content.text = temp.join("");
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
      
      private function __rightClickHandler(e:MouseEvent) : void
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
      
      private function __leftClickHandler(e:MouseEvent) : void
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
      
      private function __clickHandler(e:MouseEvent) : void
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
         var format:TextFormat = _pageTxt.defaultTextFormat;
         format.align = "center";
         _pageTxt.defaultTextFormat = format;
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
