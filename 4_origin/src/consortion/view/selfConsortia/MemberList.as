package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   
   public class MemberList extends Sprite implements Disposeable
   {
       
      
      private var _memberListBG:MovieImage;
      
      private var _menberListVLine:MutipleImage;
      
      private var _name:BaseButton;
      
      private var _job:BaseButton;
      
      private var _level:BaseButton;
      
      private var _offer:BaseButton;
      
      private var _week:BaseButton;
      
      private var _fightPower:BaseButton;
      
      private var _offLine:BaseButton;
      
      private var _search:SimpleBitmapButton;
      
      private var _nameText:FilterFrameText;
      
      private var _jobText:FilterFrameText;
      
      private var _levelText:FilterFrameText;
      
      private var _offerText:FilterFrameText;
      
      private var _weekText:FilterFrameText;
      
      private var _fightText:FilterFrameText;
      
      private var _offLineText:FilterFrameText;
      
      private var _list:ListPanel;
      
      private var _lastSort:String = "";
      
      private var _isDes:Boolean = false;
      
      private var _searchMemberFrame:SearchMemberFrame;
      
      public function MemberList()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _memberListBG = ComponentFactory.Instance.creatComponentByStylename("consortion.menberList.bg");
         _menberListVLine = ComponentFactory.Instance.creatComponentByStylename("consortion.MemberListVLine");
         _name = ComponentFactory.Instance.creatComponentByStylename("memberList.name");
         _job = ComponentFactory.Instance.creatComponentByStylename("memberList.job");
         _level = ComponentFactory.Instance.creatComponentByStylename("memberList.level");
         _offer = ComponentFactory.Instance.creatComponentByStylename("memberList.offer");
         _week = ComponentFactory.Instance.creatComponentByStylename("memberList.week");
         _fightPower = ComponentFactory.Instance.creatComponentByStylename("memberList.fightPower");
         _offLine = ComponentFactory.Instance.creatComponentByStylename("memberList.offLine");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("memberList.nameText");
         _nameText.text = LanguageMgr.GetTranslation("tank.memberList.nameText.text");
         _jobText = ComponentFactory.Instance.creatComponentByStylename("memberList.jobText");
         _jobText.text = LanguageMgr.GetTranslation("tank.memberList.jobText.text");
         _levelText = ComponentFactory.Instance.creatComponentByStylename("memberList.levelText");
         _levelText.text = LanguageMgr.GetTranslation("tank.memberList.levelText.text");
         _offerText = ComponentFactory.Instance.creatComponentByStylename("memberList.offerText");
         _offerText.text = LanguageMgr.GetTranslation("tank.memberList.offerText.text");
         _weekText = ComponentFactory.Instance.creatComponentByStylename("memberList.weekText");
         _weekText.text = LanguageMgr.GetTranslation("tank.memberList.weekText.text");
         _fightText = ComponentFactory.Instance.creatComponentByStylename("memberList.fightPowerText");
         _fightText.text = LanguageMgr.GetTranslation("tank.memberList.fightPowerText.text");
         _offLineText = ComponentFactory.Instance.creatComponentByStylename("memberList.offLineText");
         _offLineText.text = LanguageMgr.GetTranslation("tank.memberList.offLineText.text");
         _list = ComponentFactory.Instance.creatComponentByStylename("memberList.list");
         _search = ComponentFactory.Instance.creatComponentByStylename("memberList.searchBtn");
         addChild(_memberListBG);
         addChild(_menberListVLine);
         addChild(_name);
         addChild(_job);
         addChild(_level);
         addChild(_offer);
         addChild(_week);
         addChild(_fightPower);
         addChild(_offLine);
         addChild(_nameText);
         addChild(_jobText);
         addChild(_levelText);
         addChild(_offerText);
         addChild(_weekText);
         addChild(_fightText);
         addChild(_offLineText);
         addChild(_list);
         addChild(_search);
         setTip(_name,LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberList.tipArr.name"));
         setTip(_job,LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberList.tipArr.duty"));
         setTip(_level,LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberList.tipArr.level"));
         setTip(_offer,LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberList.tipArr.contribute"));
         setTip(_week,LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberList.tipArr.weekcontribute"));
         setTip(_fightPower,LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberList.tipArr.battle"));
         setTip(_offLine,LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberList.tipArr.time"));
         setTip(_search,LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberList.tipArr.search"));
         setListData();
      }
      
      private function setTip(btn:BaseButton, value:String) : void
      {
         btn.tipStyle = "ddt.view.tips.OneLineTip";
         btn.tipDirctions = "0";
         btn.tipData = value;
      }
      
      private function initEvent() : void
      {
         _name.addEventListener("click",__btnClick);
         _job.addEventListener("click",__btnClick);
         _level.addEventListener("click",__btnClick);
         _offer.addEventListener("click",__btnClick);
         _week.addEventListener("click",__btnClick);
         _fightPower.addEventListener("click",__btnClick);
         _offLine.addEventListener("click",__btnClick);
         _search.addEventListener("click",__showSearchFrame);
         ConsortionModelManager.Instance.model.addEventListener("memberListLoadComplete",__listLoadCompleteHandler);
         ConsortionModelManager.Instance.model.addEventListener("addMember",__addMemberHandler);
         ConsortionModelManager.Instance.model.addEventListener("removeMember",__removeMemberHandler);
         ConsortionModelManager.Instance.model.addEventListener("memberUpdata",__updataMemberHandler);
      }
      
      private function removeEvent() : void
      {
         if(_name)
         {
            _name.removeEventListener("click",__btnClick);
         }
         if(_job)
         {
            _job.removeEventListener("click",__btnClick);
         }
         if(_level)
         {
            _level.removeEventListener("click",__btnClick);
         }
         if(_offer)
         {
            _offer.removeEventListener("click",__btnClick);
         }
         if(_week)
         {
            _week.removeEventListener("click",__btnClick);
         }
         if(_fightPower)
         {
            _fightPower.removeEventListener("click",__btnClick);
         }
         if(_offLine)
         {
            _offLine.removeEventListener("click",__btnClick);
         }
         if(_search)
         {
            _search.removeEventListener("click",__showSearchFrame);
         }
         ConsortionModelManager.Instance.model.removeEventListener("memberListLoadComplete",__listLoadCompleteHandler);
         ConsortionModelManager.Instance.model.removeEventListener("addMember",__addMemberHandler);
         ConsortionModelManager.Instance.model.removeEventListener("removeMember",__removeMemberHandler);
         ConsortionModelManager.Instance.model.removeEventListener("memberUpdata",__updataMemberHandler);
         if(_searchMemberFrame)
         {
            _searchMemberFrame.removeEventListener("response",__onFrameEvent);
         }
      }
      
      public function __updataMemberHandler(event:ConsortionEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var target:ConsortiaPlayerInfo = event.data as ConsortiaPlayerInfo;
         var len:int = _list.vectorListModel.elements.length;
         for(i = 0; i < len; )
         {
            info = _list.vectorListModel.elements[i] as ConsortiaPlayerInfo;
            if(info.ID == target.ID)
            {
               info = target;
               break;
            }
            i++;
         }
         _list.list.updateListView();
      }
      
      public function __addMemberHandler(event:ConsortionEvent) : void
      {
         var len:int = ConsortionModelManager.Instance.model.memberList.length;
         _list.vectorListModel.append(event.data as ConsortiaPlayerInfo,len - 1);
         if(len <= 6)
         {
            _list.vectorListModel.removeElementAt(_list.vectorListModel.elements.length - 1);
         }
         _list.list.updateListView();
      }
      
      public function __removeMemberHandler(event:ConsortionEvent) : void
      {
         _list.vectorListModel.remove(event.data as ConsortiaPlayerInfo);
         var len:int = ConsortionModelManager.Instance.model.memberList.length;
         if(len < 6)
         {
            setListData();
         }
         _list.list.updateListView();
      }
      
      private function __btnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _isDes = !!_isDes?false:true;
         var _loc2_:* = event.currentTarget;
         if(_name !== _loc2_)
         {
            if(_job !== _loc2_)
            {
               if(_level !== _loc2_)
               {
                  if(_offer !== _loc2_)
                  {
                     if(_week !== _loc2_)
                     {
                        if(_fightPower !== _loc2_)
                        {
                           if(_offLine === _loc2_)
                           {
                              _lastSort = "OffLineHour";
                           }
                        }
                        else
                        {
                           _lastSort = "FightPower";
                        }
                     }
                     else
                     {
                        _lastSort = "LastWeekRichesOffer";
                     }
                  }
                  else
                  {
                     _lastSort = "UseOffer";
                  }
               }
               else
               {
                  _lastSort = "Grade";
               }
            }
            else
            {
               _lastSort = "DutyLevel";
            }
         }
         else
         {
            _lastSort = "NickName";
         }
         sortOnItem(_lastSort,_isDes);
      }
      
      private function __listLoadCompleteHandler(event:ConsortionEvent) : void
      {
         setListData();
      }
      
      private function __showSearchFrame(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_searchMemberFrame && _searchMemberFrame.parent)
         {
            return;
         }
         _searchMemberFrame = ComponentFactory.Instance.creatComponentByStylename("SearchMemberFrame");
         _searchMemberFrame.addEventListener("response",__onFrameEvent);
         LayerManager.Instance.addToLayer(_searchMemberFrame,3,true,2);
         _searchMemberFrame.setFocus();
      }
      
      private function __onFrameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               hideSearchFrame();
               break;
            case 2:
            case 3:
            case 4:
               if(search(_searchMemberFrame.getSearchText()))
               {
                  hideSearchFrame();
               }
         }
      }
      
      private function search($searchText:String) : Boolean
      {
         var i:int = 0;
         var playerInfo:* = null;
         if(FilterWordManager.isGotForbiddenWords($searchText))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.warningII"));
            return false;
         }
         if($searchText == LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.default") || $searchText == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.default"));
            return false;
         }
         if(StringHelper.getIsBiggerMaxCHchar($searchText,7))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.warningII"));
            return false;
         }
         var searchText:* = $searchText;
         var players:Array = ConsortionModelManager.Instance.model.memberList.list;
         var searchOutcome:Array = [];
         var searchComplete:Boolean = false;
         for(i = 0; i < players.length; )
         {
            playerInfo = players[i];
            if(playerInfo.NickName.indexOf(searchText) != -1)
            {
               searchOutcome.unshift(playerInfo);
               searchComplete = true;
            }
            else
            {
               searchOutcome.push(playerInfo);
            }
            i++;
         }
         if(searchText == LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.warningII"))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.default"));
            return false;
         }
         if(!searchComplete)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.warningII"));
            return false;
         }
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(searchOutcome);
         var len:int = searchOutcome.length;
         if(len < 6)
         {
            len;
            while(len < 6)
            {
               _list.vectorListModel.append(null,len);
               len++;
            }
         }
         _list.list.updateListView();
         return true;
      }
      
      private function hideSearchFrame() : void
      {
         if(_searchMemberFrame)
         {
            _searchMemberFrame.removeEventListener("response",__onFrameEvent);
            ObjectUtils.disposeObject(_searchMemberFrame);
            _searchMemberFrame = null;
         }
      }
      
      private function setListData() : void
      {
         var len:int = 0;
         if(ConsortionModelManager.Instance.model.memberList.length > 0)
         {
            _list.vectorListModel.clear();
            _list.vectorListModel.appendAll(ConsortionModelManager.Instance.model.memberList.list);
            len = ConsortionModelManager.Instance.model.memberList.length;
            if(len < 6)
            {
               len;
               while(len < 6)
               {
                  _list.vectorListModel.append(null,len);
                  len++;
               }
            }
            if(_lastSort == "")
            {
               _lastSort = "Init";
               _isDes = false;
            }
            sortOnItem(_lastSort,_isDes);
         }
      }
      
      private function sortOnItem(field:String, des:Boolean = false) : void
      {
         var i:int = 0;
         var len:int = ConsortionModelManager.Instance.model.memberList.length;
         if(len < 6)
         {
            _list.vectorListModel.elements.splice(len,6 - len + 1);
         }
         if(field == "Init")
         {
            _list.vectorListModel.elements.sortOn("Grade",19);
            for(i = 0; i < _list.vectorListModel.elements.length; )
            {
               if(_list.vectorListModel.elements[i] && _list.vectorListModel.elements[i].ID == PlayerManager.Instance.Self.ID)
               {
                  _list.vectorListModel.elements.unshift(_list.vectorListModel.elements[i]);
                  _list.vectorListModel.elements.splice(i + 1,1);
               }
               i++;
            }
         }
         else
         {
            _list.vectorListModel.elements.sortOn(field,19);
         }
         if(des)
         {
            _list.vectorListModel.elements.reverse();
         }
         if(len < 6)
         {
            len;
            while(len < 6)
            {
               _list.vectorListModel.append(null,len);
               len++;
            }
         }
         _list.list.updateListView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_list)
         {
            _list.vectorListModel.clear();
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_searchMemberFrame)
         {
            ObjectUtils.disposeObject(_searchMemberFrame);
         }
         _searchMemberFrame = null;
         if(_memberListBG)
         {
            ObjectUtils.disposeObject(_memberListBG);
         }
         _memberListBG = null;
         if(_menberListVLine)
         {
            ObjectUtils.disposeObject(_menberListVLine);
         }
         _menberListVLine = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_job)
         {
            ObjectUtils.disposeObject(_job);
         }
         _job = null;
         if(_level)
         {
            ObjectUtils.disposeObject(_level);
         }
         _level = null;
         if(_offer)
         {
            ObjectUtils.disposeObject(_offer);
         }
         _offer = null;
         if(_week)
         {
            ObjectUtils.disposeObject(_week);
         }
         _week = null;
         if(_fightPower)
         {
            ObjectUtils.disposeObject(_fightPower);
         }
         _fightPower = null;
         if(_offLine)
         {
            ObjectUtils.disposeObject(_offLine);
         }
         _offLine = null;
         if(_search)
         {
            ObjectUtils.disposeObject(_search);
         }
         _search = null;
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
         }
         _nameText = null;
         if(_jobText)
         {
            ObjectUtils.disposeObject(_jobText);
         }
         _jobText = null;
         if(_levelText)
         {
            ObjectUtils.disposeObject(_levelText);
         }
         _levelText = null;
         if(_offerText)
         {
            ObjectUtils.disposeObject(_offerText);
         }
         _offerText = null;
         if(_weekText)
         {
            ObjectUtils.disposeObject(_weekText);
         }
         _weekText = null;
         if(_fightText)
         {
            ObjectUtils.disposeObject(_fightText);
         }
         _fightText = null;
         if(_offLineText)
         {
            ObjectUtils.disposeObject(_offLineText);
         }
         _offLineText = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
