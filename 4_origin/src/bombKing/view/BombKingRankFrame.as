package bombKing.view
{
   import bombKing.components.BKingRankItem;
   import bombKing.data.BKingRankInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   
   public class BombKingRankFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _menu:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _front100Btn:SelectedTextButton;
      
      private var _front16Btn:SelectedTextButton;
      
      private var _listBg:Bitmap;
      
      private var _topTxt:FilterFrameText;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _bottomBg:MovieClip;
      
      private var _myRankImg:Bitmap;
      
      private var _bottomTxt:FilterFrameText;
      
      private var _myRank:FilterFrameText;
      
      private var _myScore:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<BKingRankItem>;
      
      private var _currentIndex:int;
      
      private var _curPage:int;
      
      private var _totalPage:int;
      
      public function BombKingRankFrame()
      {
         super();
         _itemList = new Vector.<BKingRankItem>();
         initView();
         initEvents();
         SocketManager.Instance.out.updateBombKingRank(2,1);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("bombKing.rankFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankFrame.bg");
         addToContent(_bg);
         _menu = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankFrame.hBox");
         addToContent(_menu);
         _front100Btn = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankFrame.front100Btn");
         _menu.addChild(_front100Btn);
         _front100Btn.text = "Top100";
         _front16Btn = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankFrame.front16Btn");
         _menu.addChild(_front16Btn);
         _front16Btn.text = "Top16";
         _listBg = ComponentFactory.Instance.creat("bombKing.rankFrame.listBg");
         addToContent(_listBg);
         _topTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankFrame.topTxt");
         addToContent(_topTxt);
         _topTxt.text = LanguageMgr.GetTranslation("bombKing.rankFrame.topTxt");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("bombKing.PageCountBg");
         addToContent(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.pageTxt");
         addToContent(_pageTxt);
         _pageTxt.text = "1/4";
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("bombKing.prevBtn");
         addToContent(_prevBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("bombKing.nextBtn");
         addToContent(_nextBtn);
         _bottomBg = ClassUtils.CreatInstance("bombKing.rankFrame.bottomBg");
         _bottomBg.gotoAndStop(1);
         _bottomBg.x = 11;
         _bottomBg.y = 404;
         addToContent(_bottomBg);
         _bottomTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankFrame.bottomTxt");
         addToContent(_bottomTxt);
         _bottomTxt.text = LanguageMgr.GetTranslation("bombKing.rankFrame.bottomTxt");
         _myRankImg = ComponentFactory.Instance.creat("bombKing.myRankAsset");
         addToContent(_myRankImg);
         _myRank = ComponentFactory.Instance.creatComponentByStylename("bombKing.myRankTxt");
         _myRank.text = "10";
         addToContent(_myRank);
         _myScore = ComponentFactory.Instance.creatComponentByStylename("bombKing.myScoreTxt");
         _myScore.text = "7981516";
         addToContent(_myScore);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("bombKing.vBox");
         addToContent(_vbox);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_front100Btn);
         _btnGroup.addSelectItem(_front16Btn);
         _btnGroup.selectIndex = 1;
         _currentIndex = 1;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameEventHandler);
         _btnGroup.addEventListener("change",__changeHandler);
         _prevBtn.addEventListener("click",__prevBtnClick);
         _nextBtn.addEventListener("click",__nextBtnClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(263,5),__updateRank);
      }
      
      protected function __updateRank(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         _currentIndex = _loc5_.readInt();
         _btnGroup.selectIndex = _currentIndex;
         _totalPage = _loc5_.readInt();
         _curPage = _loc5_.readInt();
         _curPage = _totalPage <= 0?0:_curPage;
         _pageTxt.text = _curPage + "/" + _totalPage;
         clearItems();
         var _loc3_:int = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ <= _loc3_ - 1)
         {
            _loc6_ = new BKingRankInfo();
            _loc6_.place = _loc5_.readInt();
            _loc6_.userId = _loc5_.readInt();
            _loc6_.areaId = _loc5_.readInt();
            _loc6_.name = _loc5_.readUTF();
            _loc6_.areaName = _loc5_.readUTF();
            _loc6_.vipType = _loc5_.readInt();
            _loc6_.vipLvl = _loc5_.readInt();
            _loc6_.num = _loc5_.readInt();
            _loc4_ = new BKingRankItem();
            _loc4_.info = _loc6_;
            _itemList.push(_loc4_);
            _vbox.addChild(_loc4_);
            _loc7_++;
         }
         var _loc2_:int = _loc5_.readInt();
         if(_loc2_ <= 0)
         {
            _myRank.text = LanguageMgr.GetTranslation("bombKing.outOfRank2");
         }
         else
         {
            _myRank.text = _loc2_.toString();
         }
         _myScore.text = _loc5_.readInt().toString();
      }
      
      protected function __changeHandler(param1:Event) : void
      {
         if(_btnGroup.selectIndex == _currentIndex)
         {
            return;
         }
         SoundManager.instance.play("008");
         _currentIndex = _btnGroup.selectIndex;
         SocketManager.Instance.out.updateBombKingRank(_currentIndex,1);
      }
      
      protected function __prevBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_curPage <= 1)
         {
            return;
         }
         SocketManager.Instance.out.updateBombKingRank(_currentIndex,_curPage - 1);
      }
      
      protected function __nextBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_curPage >= _totalPage)
         {
            return;
         }
         SocketManager.Instance.out.updateBombKingRank(_currentIndex,_curPage + 1);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",__frameEventHandler);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function clearItems() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ <= _itemList.length - 1)
         {
            ObjectUtils.disposeObject(_itemList[_loc1_]);
            _itemList[_loc1_] = null;
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__changeHandler);
         }
         if(_prevBtn)
         {
            _prevBtn.removeEventListener("click",__prevBtnClick);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnClick);
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(263,5),__updateRank);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearItems();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeObject(_front100Btn);
         _front100Btn = null;
         ObjectUtils.disposeObject(_front16Btn);
         _front16Btn = null;
         ObjectUtils.disposeObject(_listBg);
         _listBg = null;
         ObjectUtils.disposeObject(_topTxt);
         _topTxt = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_prevBtn);
         _prevBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_myRankImg);
         _myRankImg = null;
         ObjectUtils.disposeObject(_myRank);
         _myRank = null;
         ObjectUtils.disposeObject(_myScore);
         _myScore = null;
         ObjectUtils.disposeObject(_bottomTxt);
         _bottomBg = null;
         super.dispose();
      }
   }
}
