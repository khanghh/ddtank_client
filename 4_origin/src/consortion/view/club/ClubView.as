package consortion.view.club
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import trainer.view.NewHandContainer;
   
   public class ClubView extends Sprite implements Disposeable
   {
       
      
      private var _consortiaClubPage:int = 1;
      
      private var _consortionList:ConsortionList;
      
      private var _recordList:ClubRecordList;
      
      private var _BG:MovieImage;
      
      private var _clubBG:MovieImage;
      
      private var _wordsImage:MutipleImage;
      
      private var _searchInput:TextInput;
      
      private var _searchBtn:TextButton;
      
      private var _declareBG:MutipleImage;
      
      private var _declaration:TextArea;
      
      private var _applyBtn:BaseButton;
      
      private var _randomSearchBtn:BaseButton;
      
      private var _recordGroup:SelectedButtonGroup;
      
      private var _applyRecordBtn:SelectedTextButton;
      
      private var _inviteRecordBtn:SelectedTextButton;
      
      private var _createConsortionBtn:BaseButton;
      
      private var _menberListVLine:MutipleImage;
      
      private var _searchText:FilterFrameText;
      
      private var _inputBG:MutipleImage;
      
      private var _consortionNameTxt:FilterFrameText;
      
      private var _chairmanNameTxt:FilterFrameText;
      
      private var _menberCountTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _exploitTxt:FilterFrameText;
      
      private var _littleFur1:ScaleFrameImage;
      
      private var _littleFur2:ScaleFrameImage;
      
      private var _dottedline:MutipleImage;
      
      public function ClubView()
      {
         super();
      }
      
      public function enterClub() : void
      {
         ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.clubSearchConsortions,1,6,"",Math.floor(Math.random() * 5 + 1),1);
         ConsortionModelManager.Instance.getApplyRecordList(ConsortionModelManager.Instance.applyListComplete,PlayerManager.Instance.Self.ID);
         ConsortionModelManager.Instance.getInviteRecordList(ConsortionModelManager.Instance.InventListComplete);
         init();
         initEvent();
         __consortionListComplete(null);
      }
      
      private function init() : void
      {
         _BG = ComponentFactory.Instance.creatComponentByStylename("consortionClub.BG");
         _clubBG = ComponentFactory.Instance.creatComponentByStylename("club.menberList.bg");
         _menberListVLine = ComponentFactory.Instance.creatComponentByStylename("consortionClub.MemberListVLine");
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("consortionClubView.InputBG");
         _searchText = ComponentFactory.Instance.creatComponentByStylename("consortionClubView.searchText");
         _searchText.text = LanguageMgr.GetTranslation("tank.consortionClubView.searchText.text");
         _consortionNameTxt = ComponentFactory.Instance.creatComponentByStylename("consortionClub.MemberListTitleText1");
         _consortionNameTxt.text = LanguageMgr.GetTranslation("tank.consortionClub.MemberListTitleText1.text");
         _chairmanNameTxt = ComponentFactory.Instance.creatComponentByStylename("consortionClub.MemberListTitleText2");
         _chairmanNameTxt.text = LanguageMgr.GetTranslation("tank.consortionClub.MemberListTitleText2.text");
         _menberCountTxt = ComponentFactory.Instance.creatComponentByStylename("consortionClub.MemberListTitleText3");
         _menberCountTxt.text = LanguageMgr.GetTranslation("tank.consortionClub.MemberListTitleText3.text");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("consortionClub.MemberListTitleText4");
         _gradeTxt.text = LanguageMgr.GetTranslation("tank.consortionClub.MemberListTitleText4.text");
         _exploitTxt = ComponentFactory.Instance.creatComponentByStylename("consortionClub.MemberListTitleText5");
         _exploitTxt.text = LanguageMgr.GetTranslation("tank.consortionClub.MemberListTitleText5.text");
         _wordsImage = ComponentFactory.Instance.creatComponentByStylename("club.wordImage.mutiple");
         _consortionList = ComponentFactory.Instance.creatComponentByStylename("club.consortionList");
         _searchInput = ComponentFactory.Instance.creatComponentByStylename("club.searchInput");
         _searchInput.text = LanguageMgr.GetTranslation("tank.consortia.club.searchTxt");
         _searchBtn = ComponentFactory.Instance.creatComponentByStylename("club.searchConsortionBtn");
         _searchBtn.text = LanguageMgr.GetTranslation("tank.consortia.club.searchTxt.text");
         _declareBG = ComponentFactory.Instance.creatComponentByStylename("club.declareBG");
         _declaration = ComponentFactory.Instance.creatComponentByStylename("club.declaration");
         _applyBtn = ComponentFactory.Instance.creatComponentByStylename("club.applyBtn");
         _randomSearchBtn = ComponentFactory.Instance.creatComponentByStylename("club.randomSearchBtn");
         _recordGroup = new SelectedButtonGroup(false);
         _applyRecordBtn = ComponentFactory.Instance.creatComponentByStylename("club.applyRecordBtn");
         _applyRecordBtn.text = LanguageMgr.GetTranslation("club.applyRecordBtnText");
         _inviteRecordBtn = ComponentFactory.Instance.creatComponentByStylename("club.inviteRecordBtn");
         _inviteRecordBtn.text = LanguageMgr.GetTranslation("club.inviteRecordBtnText");
         _littleFur1 = ComponentFactory.Instance.creatComponentByStylename("club.Scale9CornerImage.littleFurI");
         _littleFur1.setFrame(1);
         _littleFur2 = ComponentFactory.Instance.creatComponentByStylename("club.Scale9CornerImage.littleFurII");
         _littleFur2.setFrame(2);
         _dottedline = ComponentFactory.Instance.creatComponentByStylename("club.dottedline");
         _recordGroup.addSelectItem(_inviteRecordBtn);
         _recordGroup.addSelectItem(_applyRecordBtn);
         _recordGroup.selectIndex = 0;
         _recordList = ComponentFactory.Instance.creatCustomObject("club.recordList");
         _createConsortionBtn = ComponentFactory.Instance.creatComponentByStylename("club.createConsortion");
         addChild(_BG);
         addChild(_clubBG);
         addChild(_menberListVLine);
         addChild(_inputBG);
         addChild(_searchText);
         addChild(_consortionNameTxt);
         addChild(_chairmanNameTxt);
         addChild(_menberCountTxt);
         addChild(_gradeTxt);
         addChild(_exploitTxt);
         addChild(_declareBG);
         addChild(_wordsImage);
         addChild(_consortionList);
         addChild(_searchInput);
         addChild(_searchBtn);
         addChild(_declaration);
         addChild(_applyBtn);
         addChild(_randomSearchBtn);
         addChild(_littleFur1);
         addChild(_littleFur2);
         addChild(_applyRecordBtn);
         addChild(_inviteRecordBtn);
         addChild(_dottedline);
         addChild(_recordList);
         addChild(_createConsortionBtn);
         __recordListChange(null);
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(15) && !PlayerManager.Instance.Self.IsWeakGuildFinish(65))
         {
            NewHandContainer.Instance.showArrow(65,-45,new Point(44,104),"","",LayerManager.Instance.getLayerByType(2),0,true);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("addedToStage",__addToStageHandler);
         _searchBtn.addEventListener("click",__sarchWithInputHandler);
         _applyBtn.addEventListener("click",__applyHandler);
         _randomSearchBtn.addEventListener("click",__randomSearchHandler);
         _consortionList.addEventListener("ClubItemSelected",__selectedOneConsortion);
         _applyRecordBtn.addEventListener("click",__recordBtnClickHandler);
         _inviteRecordBtn.addEventListener("click",__recordBtnClickHandler);
         _createConsortionBtn.addEventListener("click",__createConsortionHandler);
         ConsortionModelManager.Instance.model.addEventListener("consortionListIsChange",__consortionListComplete);
         ConsortionModelManager.Instance.model.addEventListener("inventListIsChange",__recordListChange);
         ConsortionModelManager.Instance.model.addEventListener("myApplyListIsChange",__recordListChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         _searchInput.removeEventListener("click",__focusInHandler);
         _searchInput.removeEventListener("focusOut",__focusOutHandler);
         _searchInput.removeEventListener("keyDown",__keyDownHandler);
         _searchBtn.removeEventListener("click",__sarchWithInputHandler);
         _applyBtn.removeEventListener("click",__applyHandler);
         _randomSearchBtn.removeEventListener("click",__randomSearchHandler);
         _consortionList.removeEventListener("ClubItemSelected",__selectedOneConsortion);
         _applyRecordBtn.removeEventListener("click",__recordBtnClickHandler);
         _inviteRecordBtn.removeEventListener("click",__recordBtnClickHandler);
         _createConsortionBtn.removeEventListener("click",__createConsortionHandler);
         ConsortionModelManager.Instance.model.removeEventListener("consortionListIsChange",__consortionListComplete);
         ConsortionModelManager.Instance.model.removeEventListener("inventListIsChange",__recordListChange);
         ConsortionModelManager.Instance.model.removeEventListener("myApplyListIsChange",__recordListChange);
      }
      
      private function __createConsortionHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var createConsortia:CreateConsortionFrame = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame");
         LayerManager.Instance.addToLayer(createConsortia,3,true,1);
      }
      
      private function __addToStageHandler(event:Event) : void
      {
         _searchInput.addEventListener("click",__focusInHandler);
         _searchInput.addEventListener("focusOut",__focusOutHandler);
         _searchInput.addEventListener("keyDown",__keyDownHandler);
      }
      
      private function __keyDownHandler(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            __sarchWithInputHandler(null);
         }
      }
      
      private function __recordBtnClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         __recordListChange(null);
      }
      
      private function __recordListChange(event:ConsortionEvent) : void
      {
         switch(int(_recordGroup.selectIndex))
         {
            case 0:
               _recordList.setData(ConsortionModelManager.Instance.model.inventList,1);
               break;
            case 1:
               _recordList.setData(ConsortionModelManager.Instance.model.myApplyList,2);
         }
      }
      
      private function __applyHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade < 17)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.playerTip.notInvite",17));
            return;
         }
         if(!_consortionList.currentItem.info.OpenApply)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.ConsortiaClubView.applyJoinClickHandler"));
            return;
         }
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(15) && !PlayerManager.Instance.Self.IsWeakGuildFinish(65))
         {
            SocketManager.Instance.out.syncWeakStep(65);
         }
         NewHandContainer.Instance.hideGuideCover();
         NewHandContainer.Instance.clearArrowByID(65);
         _consortionList.currentItem.isApply = true;
         _applyBtn.enable = false;
         _recordGroup.selectIndex = 1;
         SocketManager.Instance.out.sendConsortiaTryIn(_consortionList.currentItem.info.ConsortiaID);
      }
      
      private function __randomSearchHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _consortiaClubPage = Number(_consortiaClubPage) + 1;
         var totalCount:int = ConsortionModelManager.Instance.model.consortionsListTotalCount;
         if(totalCount != 0)
         {
            if(_consortiaClubPage > totalCount)
            {
               _consortiaClubPage = 1;
            }
         }
         else
         {
            _consortiaClubPage = 1;
         }
         ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.clubSearchConsortions,_consortiaClubPage,6);
      }
      
      private function __selectedOneConsortion(event:ConsortionEvent) : void
      {
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(15) && !PlayerManager.Instance.Self.IsWeakGuildFinish(65))
         {
            NewHandContainer.Instance.showArrow(65,140,new Point(144,432),"","",LayerManager.Instance.getLayerByType(2),0,true);
         }
         if(_consortionList.currentItem.info == null)
         {
            return;
         }
         _declaration.text = _consortionList.currentItem.info.Description;
         if(_declaration.text == "")
         {
            _declaration.text = LanguageMgr.GetTranslation("tank.consortia.club.text");
         }
         _applyBtn.enable = true;
      }
      
      private function __consortionListComplete(event:ConsortionEvent) : void
      {
         _consortionList.setListData(ConsortionModelManager.Instance.model.consortionList);
         _declaration.text = "";
         _applyBtn.enable = false;
      }
      
      private function __focusInHandler(event:MouseEvent) : void
      {
         if(_searchInput.text == LanguageMgr.GetTranslation("tank.consortia.club.searchTxt"))
         {
            _searchInput.text = "";
         }
      }
      
      private function __focusOutHandler(event:FocusEvent) : void
      {
         if(_searchInput.text == "")
         {
            _searchInput.text = LanguageMgr.GetTranslation("tank.consortia.club.searchTxt");
         }
      }
      
      private function __sarchWithInputHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _consortiaClubPage = Number(_consortiaClubPage) + 1;
         var totalCount:int = ConsortionModelManager.Instance.model.consortionsListTotalCount;
         if(totalCount != 0)
         {
            if(_consortiaClubPage > totalCount)
            {
               _consortiaClubPage = 1;
            }
         }
         if(_searchInput.text == "" || _searchInput.text == LanguageMgr.GetTranslation("tank.consortia.club.searchTxt"))
         {
            ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.clubSearchConsortions,_consortiaClubPage,6);
         }
         else
         {
            ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.clubSearchConsortions,_consortiaClubPage,6,_searchInput.text);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _consortionList = null;
         _recordList = null;
         _BG = null;
         _clubBG = null;
         _menberListVLine = null;
         _searchText = null;
         _inputBG = null;
         _consortionNameTxt = null;
         _chairmanNameTxt = null;
         _menberCountTxt = null;
         _gradeTxt = null;
         _exploitTxt = null;
         _wordsImage = null;
         _searchInput = null;
         if(_searchBtn)
         {
            ObjectUtils.disposeObject(_searchBtn);
         }
         _searchBtn = null;
         _declareBG = null;
         _declaration = null;
         _applyBtn = null;
         _randomSearchBtn = null;
         _recordGroup = null;
         _applyRecordBtn = null;
         _inviteRecordBtn = null;
         _littleFur1 = null;
         _littleFur2 = null;
         _dottedline = null;
         _createConsortionBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
