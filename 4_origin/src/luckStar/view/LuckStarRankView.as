package luckStar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import luckStar.LoadingLuckStarUI;
   import luckStar.manager.LuckStarManager;
   import luckStar.model.LuckStarPlayerInfo;
   
   public class LuckStarRankView extends Sprite implements Disposeable
   {
      
      private static const MAX_RANK_VIEW:int = 5;
      
      private static const MAX_PAGE:int = 2;
      
      private static const MAX_AWARD:int = 3;
      
      private static const REQUEST_TIME:int = 300000;
       
      
      private var _rankBG:Bitmap;
      
      private var _awardListBG:Bitmap;
      
      private var _awardBtn:BaseButton;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _pageBG:Scale9CornerImage;
      
      private var _pageText:FilterFrameText;
      
      private var _updateTimeText:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _myRankText:FilterFrameText;
      
      private var _luckyStarNumText:FilterFrameText;
      
      private var _rankInfo:Vector.<LuckStarRankItem>;
      
      private var _currentPage:int = 1;
      
      private var _maxPage:int = 1;
      
      private var _newAward:Sprite;
      
      private var _newAwardList:Vector.<LuckStarNewAwardItem>;
      
      private var _list:Vector.<Array>;
      
      private var _isMove:Boolean = false;
      
      private var _textHeight:int;
      
      private var _awardView:LuckStarAwardView;
      
      private var _index:int;
      
      private var _rankTitle:FilterFrameText;
      
      private var _rankName:FilterFrameText;
      
      private var _rankNum:FilterFrameText;
      
      private var _awardNmae:FilterFrameText;
      
      private var _awardListText:FilterFrameText;
      
      private var _time:Timer;
      
      private var _helpText:FilterFrameText;
      
      public function LuckStarRankView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var rankItem:* = null;
         var awardItem:* = null;
         _rankBG = ComponentFactory.Instance.creat("luckyStar.view.RankBG");
         _awardListBG = ComponentFactory.Instance.creat("luckyStar.view.NewAwardListBG");
         _awardBtn = ComponentFactory.Instance.creat("luckyStar.view.AwardBtn");
         _preBtn = ComponentFactory.Instance.creat("luckyStar.view.preBtn");
         _nextBtn = ComponentFactory.Instance.creat("luckyStar.view.nextBtn");
         _pageBG = ComponentFactory.Instance.creat("luckyStar.view.pageLastBg");
         _pageText = ComponentFactory.Instance.creat("luckyStar.view.pageText");
         _updateTimeText = ComponentFactory.Instance.creat("luckyStar.view.updateTimeText");
         _myRankText = ComponentFactory.Instance.creat("luckyStar.view.myRankText");
         _luckyStarNumText = ComponentFactory.Instance.creat("luckyStar.view.luckyStarNumText");
         _timeText = ComponentFactory.Instance.creat("luckyStar.view.timeText");
         _rankTitle = ComponentFactory.Instance.creat("luckyStar.view.rankTitle");
         _rankTitle.text = LanguageMgr.GetTranslation("repute");
         _rankName = ComponentFactory.Instance.creat("luckyStar.view.rankName");
         _rankName.text = LanguageMgr.GetTranslation("civil.rightview.listname");
         _rankNum = ComponentFactory.Instance.creat("luckyStar.view.rankNum");
         _rankNum.text = LanguageMgr.GetTranslation("ddt.luckStar.useStarNum");
         _awardNmae = ComponentFactory.Instance.creat("luckyStar.view.awardNum");
         _awardNmae.text = LanguageMgr.GetTranslation("itemview.listname");
         _awardListText = ComponentFactory.Instance.creat("luckyStar.view.awardListText");
         _awardListText.text = LanguageMgr.GetTranslation("ddt.luckStar.awardList");
         _helpText = ComponentFactory.Instance.creat("luckyStar.view.helpTextText");
         _newAward = new Sprite();
         _newAward.scrollRect = ComponentFactory.Instance.creat("luckyStar.view.newAwardViewRec");
         PositionUtils.setPos(_newAward,"luckyStar.view.newAwardPos");
         addChild(_rankBG);
         addChild(_awardListBG);
         addChild(_awardBtn);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageBG);
         addChild(_pageText);
         addChild(_updateTimeText);
         addChild(_myRankText);
         addChild(_luckyStarNumText);
         addChild(_timeText);
         addChild(_newAward);
         addChild(_rankTitle);
         addChild(_rankName);
         addChild(_rankNum);
         addChild(_awardNmae);
         addChild(_awardListText);
         addChild(_helpText);
         var itemY:int = 87;
         var addNum:int = 35;
         var itemX:int = 24;
         _rankInfo = new Vector.<LuckStarRankItem>();
         for(i = 0; i < 5; )
         {
            rankItem = new LuckStarRankItem();
            rankItem.x = itemX;
            rankItem.y = itemY;
            itemY = itemY + addNum;
            addChild(rankItem);
            _rankInfo.push(rankItem);
            i++;
         }
         _newAwardList = new Vector.<LuckStarNewAwardItem>();
         for(i = 0; i < 3; )
         {
            awardItem = new LuckStarNewAwardItem();
            _textHeight = awardItem.height;
            awardItem.y = _textHeight * i;
            _newAward.addChild(awardItem);
            _newAwardList.push(awardItem);
            i++;
         }
         _awardBtn.addEventListener("click",__onAwardClick);
         _preBtn.addEventListener("click",__onPreClick);
         _nextBtn.addEventListener("click",__onNextClick);
         _time = new Timer(300000,1);
         _time.addEventListener("timerComplete",__onTimer);
         _time.start();
         currentPage = 1;
         updateActivityDate();
         updateNewAwardList();
         updateHelpText();
      }
      
      public function updateNewAwardList() : void
      {
         _list = LuckStarManager.Instance.model.newRewardList;
         moreItemPlay();
      }
      
      public function insertNewAwardItem(name:String, award:int, count:int) : void
      {
         var awardItem:LuckStarNewAwardItem = new LuckStarNewAwardItem();
         awardItem.setText(name,award,count);
         awardItem.y = _newAwardList[_newAwardList.length - 1].y + _textHeight;
         _newAward.addChild(awardItem);
         _newAwardList.push(awardItem);
         if(_newAwardList.length > 3)
         {
            if(!_isMove)
            {
               addEventListener("enterFrame",__onMove);
            }
            _isMove = true;
         }
      }
      
      private function __onMove(e:Event) : void
      {
         var i:int = 0;
         if(!_isMove)
         {
            return;
         }
         var len:int = _newAwardList.length;
         for(i = 0; i < len; )
         {
            _newAwardList[i].y = _newAwardList[i].y - 1;
            i++;
         }
         check();
      }
      
      private function check() : void
      {
         if(_newAwardList.length > 3)
         {
            if(Math.abs(_newAwardList[0].y) > _textHeight)
            {
               ObjectUtils.disposeObject(_newAwardList.shift());
               if(_newAwardList.length == 3)
               {
                  _isMove = false;
                  _newAwardList[0].y = 0;
                  _newAwardList[1].y = _textHeight;
                  _newAwardList[2].y = _textHeight * 2;
                  removeEventListener("enterFrame",__onMove);
                  moreItemPlay();
               }
               _index = Number(_index) + 1;
            }
         }
      }
      
      private function moreItemPlay() : void
      {
         if(_list != null && _list.length > 0)
         {
            if(_index >= _list.length)
            {
               _index = 0;
            }
            insertNewAwardItem(_list[_index][2],int(_list[_index][0]),int(_list[_index][1]));
         }
      }
      
      private function __onPreClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var index:int = _currentPage - 1;
         if(index < 1)
         {
            index = _maxPage;
         }
         currentPage = index;
      }
      
      private function __onNextClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var index:int = _currentPage + 1;
         if(index > _maxPage)
         {
            index = 1;
         }
         currentPage = index;
      }
      
      private function __onAwardClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_awardView == null)
         {
            _awardView = new LuckStarAwardView();
         }
         if(_awardView.parent == null)
         {
            addChild(_awardView);
         }
      }
      
      private function set currentPage(value:int) : void
      {
         if(_currentPage == value)
         {
            return;
         }
         _currentPage = value;
         updateRankInfo();
      }
      
      public function updateRankInfo() : void
      {
         var i:int = 0;
         if(LuckStarManager.Instance.model.rank == null || LuckStarManager.Instance.model.rank.length == 0)
         {
            return;
         }
         _maxPage = LuckStarManager.Instance.model.rank.length;
         _pageText.text = _currentPage.toString() + "/" + _maxPage.toString();
         var info:Vector.<LuckStarPlayerInfo> = LuckStarManager.Instance.model.rank[_currentPage - 1] as Vector.<LuckStarPlayerInfo>;
         for(i = 0; i < 5; )
         {
            _rankInfo[i].resetItem();
            if(i < info.length && info[i] != null)
            {
               _rankInfo[i].info = info[i];
            }
            i++;
         }
      }
      
      public function lastUpdateTime() : void
      {
         _updateTimeText.text = LanguageMgr.GetTranslation("ddt.luckStar.updateTime",LuckStarManager.Instance.model.lastDate);
      }
      
      public function updateSelfInfo() : void
      {
         var info:LuckStarPlayerInfo = LuckStarManager.Instance.model.selfInfo;
         if(info)
         {
            _myRankText.text = info.rank.toString();
            _luckyStarNumText.text = info.starNum.toString();
         }
      }
      
      public function updateHelpText() : void
      {
         _helpText.text = LanguageMgr.GetTranslation("ddt.luckStar.useLuckStarHelp",LuckStarManager.Instance.model.minUseNum);
      }
      
      public function updateActivityDate() : void
      {
         var start:* = null;
         var end:* = null;
         var str1:* = null;
         var str2:* = null;
         var arr:Array = LuckStarManager.Instance.model.activityDate;
         if(arr)
         {
            start = arr[0] as Date;
            end = arr[1] as Date;
            str1 = LanguageMgr.GetTranslation("ddt.luckStar.fullDate",start.getFullYear(),start.getMonth() + 1,start.getDate());
            str2 = LanguageMgr.GetTranslation("ddt.luckStar.fullDate",end.getFullYear(),end.getMonth() + 1,end.getDate());
            _timeText.text = LanguageMgr.GetTranslation("ddt.luckStar.activityTime",str1,str2);
         }
      }
      
      private function __onTimer(e:TimerEvent) : void
      {
         LoadingLuckStarUI.Instance.RequestActivityRank();
         _time.reset();
         _time.start();
      }
      
      public function dispose() : void
      {
         _time.stop();
         _time.removeEventListener("timerComplete",__onTimer);
         _time = null;
         _awardBtn.removeEventListener("click",__onAwardClick);
         _preBtn.removeEventListener("click",__onPreClick);
         _nextBtn.removeEventListener("click",__onNextClick);
         if(_isMove)
         {
            _isMove = false;
            removeEventListener("enterFrame",__onMove);
         }
         ObjectUtils.disposeObject(_rankBG);
         _rankBG = null;
         ObjectUtils.disposeObject(_awardListBG);
         _awardListBG = null;
         ObjectUtils.disposeObject(_awardBtn);
         _awardBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageBG);
         _pageBG = null;
         ObjectUtils.disposeObject(_pageText);
         _pageText = null;
         ObjectUtils.disposeObject(_updateTimeText);
         _updateTimeText = null;
         ObjectUtils.disposeObject(_myRankText);
         _myRankText = null;
         ObjectUtils.disposeObject(_luckyStarNumText);
         _luckyStarNumText = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_awardView);
         _awardView = null;
         ObjectUtils.disposeObject(_rankTitle);
         _rankTitle = null;
         ObjectUtils.disposeObject(_rankName);
         _rankName = null;
         ObjectUtils.disposeObject(_rankNum);
         _rankNum = null;
         ObjectUtils.disposeObject(_awardNmae);
         _awardNmae = null;
         ObjectUtils.disposeObject(_awardListText);
         _awardListText = null;
         ObjectUtils.disposeObject(_helpText);
         _helpText = null;
         while(_rankInfo.length)
         {
            ObjectUtils.disposeObject(_rankInfo.pop());
         }
         _rankInfo = null;
         while(_newAwardList.length)
         {
            ObjectUtils.disposeObject(_newAwardList.pop());
         }
         _newAwardList = null;
         _newAward = null;
      }
   }
}
