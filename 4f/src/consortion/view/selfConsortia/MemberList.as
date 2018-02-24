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
      
      public function MemberList(){super();}
      
      private function initView() : void{}
      
      private function setTip(param1:BaseButton, param2:String) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function __updataMemberHandler(param1:ConsortionEvent) : void{}
      
      public function __addMemberHandler(param1:ConsortionEvent) : void{}
      
      public function __removeMemberHandler(param1:ConsortionEvent) : void{}
      
      private function __btnClick(param1:MouseEvent) : void{}
      
      private function __listLoadCompleteHandler(param1:ConsortionEvent) : void{}
      
      private function __showSearchFrame(param1:MouseEvent) : void{}
      
      private function __onFrameEvent(param1:FrameEvent) : void{}
      
      private function search(param1:String) : Boolean{return false;}
      
      private function hideSearchFrame() : void{}
      
      private function setListData() : void{}
      
      private function sortOnItem(param1:String, param2:Boolean = false) : void{}
      
      public function dispose() : void{}
   }
}
