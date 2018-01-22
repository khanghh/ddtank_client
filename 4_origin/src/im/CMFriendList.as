package im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.CMFriendInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   
   public class CMFriendList extends Sprite implements Disposeable
   {
      
      public static const LIST_MAX_NUM:int = 5;
       
      
      private var _list:VBox;
      
      private var _CMFriendArray:Array;
      
      private var _CMFriendItemArray:Array;
      
      private var _title:IMListItemView;
      
      private var _titleInfo:FriendListPlayer;
      
      private var _titleII:IMListItemView;
      
      private var _titleInfoII:FriendListPlayer;
      
      private var _currentTitleInfo:FriendListPlayer;
      
      private var _playCurrentPage:int;
      
      private var _playDDTListTotalPage:int;
      
      private var _unplayCurrentPage:int;
      
      private var _unplayDDTListTotalPage:int;
      
      private var _upPageBtn:BaseButton;
      
      private var _downPageBtn:BaseButton;
      
      private var _InviteBlogBtn:TextButton;
      
      private var _switchBtn1:SelectedCheckButton;
      
      private var _switchBtn2:SelectedCheckButton;
      
      private var _currentCMFInfo:CMFriendInfo;
      
      public function CMFriendList()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("IM.CMFriendList.CMFriendList");
         addChild(_list);
         _CMFriendItemArray = [];
         _upPageBtn = ComponentFactory.Instance.creatComponentByStylename("IM.CMFriendList.upPageBtn");
         addChild(_upPageBtn);
         _downPageBtn = ComponentFactory.Instance.creatComponentByStylename("IM.CMFriendList.downPageBtn");
         addChild(_downPageBtn);
         _InviteBlogBtn = ComponentFactory.Instance.creatComponentByStylename("IM.CMFriendList.InviteBlogBtn");
         _InviteBlogBtn.text = LanguageMgr.GetTranslation("tank.view.im.InviteBtn");
         addChild(_InviteBlogBtn);
         _switchBtn1 = ComponentFactory.Instance.creatComponentByStylename("core.switchBtn1");
         _switchBtn1.selected = SharedManager.Instance.autoSnsSend;
         if(!_switchBtn1.selected)
         {
            _switchBtn1.tipData = LanguageMgr.GetTranslation("im.CMFriendList.switchBtn1.tipData1");
         }
         else
         {
            _switchBtn1.tipData = LanguageMgr.GetTranslation("im.CMFriendList.switchBtn1.tipData2");
         }
         addChild(_switchBtn1);
         _switchBtn2 = ComponentFactory.Instance.creatComponentByStylename("core.switchBtn2");
         _switchBtn2.selected = SharedManager.Instance.allowSnsSend;
         if(!_switchBtn2.selected)
         {
            _switchBtn2.tipData = LanguageMgr.GetTranslation("im.CMFriendList.switchBtn2.tipData1");
         }
         else
         {
            _switchBtn2.tipData = LanguageMgr.GetTranslation("im.CMFriendList.switchBtn2.tipData2");
         }
         addChild(_switchBtn2);
         if(!(PathManager.CommnuntyMicroBlog() && PathManager.CommnuntySinaSecondMicroBlog()))
         {
            _InviteBlogBtn.visible = false;
            _upPageBtn.x = 22;
            _downPageBtn.x = 100;
            _switchBtn1.x = 186;
            _switchBtn2.x = 214;
         }
         initTitle();
         updatePageBtnState();
      }
      
      private function initTitle() : void
      {
         _titleInfo = new FriendListPlayer();
         _titleInfo.type = 0;
         _titleInfo.titleType = 0;
         _titleInfo.titleIsSelected = false;
         _titleInfo.titleNumText = "";
         _titleInfo.titleText = LanguageMgr.GetTranslation("im.CMFriendList.title");
         _title = new IMListItemView();
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("IM.CMFriendList.titlePos");
         _title.setCellValue(_titleInfo);
         _title.x = _loc1_.x;
         _title.y = _loc1_.y;
         addChild(_title);
         _titleInfoII = new FriendListPlayer();
         _titleInfoII.type = 0;
         _titleInfoII.titleType = 1;
         _titleInfoII.titleIsSelected = false;
         _titleInfoII.titleNumText = "";
         _titleInfoII.titleText = LanguageMgr.GetTranslation("im.CMFriendList.titleII");
         _titleII = new IMListItemView();
         _titleII.setCellValue(_titleInfoII);
         addChild(_titleII);
         _currentTitleInfo = _titleInfo;
         if(PlayerManager.Instance.CMFriendList)
         {
            creatItem();
            updateList();
         }
         else
         {
            updateListPos();
         }
         if(PathManager.CommnuntyMicroBlog() && PathManager.CommnuntySinaSecondMicroBlog())
         {
            _titleII.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         _title.addEventListener("click",__titleClick);
         _titleII.addEventListener("click",__titleClick);
         _upPageBtn.addEventListener("click",__pageBtnClick);
         _downPageBtn.addEventListener("click",__pageBtnClick);
         _InviteBlogBtn.addEventListener("click",__inviteBolg);
         _switchBtn1.addEventListener("click",__switchBtn1Click);
         _switchBtn2.addEventListener("click",__switchBtn2Click);
      }
      
      private function __pageBtnClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _upPageBtn)
         {
            if(_currentTitleInfo.titleType == 0 && _currentTitleInfo.titleIsSelected)
            {
               _playCurrentPage = Number(_playCurrentPage) - 1;
            }
            else if(_currentTitleInfo.titleType == 1 && _currentTitleInfo.titleIsSelected)
            {
               _unplayCurrentPage = Number(_unplayCurrentPage) - 1;
            }
         }
         else if(param1.currentTarget == _downPageBtn)
         {
            if(_currentTitleInfo.titleType == 0 && _currentTitleInfo.titleIsSelected)
            {
               _playCurrentPage = Number(_playCurrentPage) + 1;
            }
            else if(_currentTitleInfo.titleType == 1 && _currentTitleInfo.titleIsSelected)
            {
               _unplayCurrentPage = Number(_unplayCurrentPage) + 1;
            }
         }
         updateItem();
         SoundManager.instance.play("008");
         updatePageBtnState();
      }
      
      private function __inviteBolg(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ExternalInterface.available)
         {
            ExternalInterface.call("showInviteBox",PlayerManager.Instance.Self.ZoneID,PlayerManager.Instance.Self.ID);
         }
      }
      
      private function updatePageBtnState() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:Boolean = false;
         _downPageBtn.enable = _loc3_;
         _upPageBtn.enable = _loc3_;
         if(_currentTitleInfo.titleType == 0 && _currentTitleInfo.titleIsSelected)
         {
            _loc2_ = _playCurrentPage;
            _loc1_ = _playDDTListTotalPage;
         }
         else if(_currentTitleInfo.titleType == 1 && _currentTitleInfo.titleIsSelected)
         {
            _loc2_ = _unplayCurrentPage;
            _loc1_ = _unplayDDTListTotalPage;
         }
         if(_loc1_ > 1)
         {
            if(_loc2_ > 0 && _loc2_ < _loc1_ - 1)
            {
               _loc3_ = true;
               _downPageBtn.enable = _loc3_;
               _upPageBtn.enable = _loc3_;
            }
            else if(_loc2_ <= 0 && _loc2_ < _loc1_ - 1)
            {
               _downPageBtn.enable = true;
            }
            else if(_loc2_ > 0 && _loc2_ >= _loc1_ - 1)
            {
               _upPageBtn.enable = true;
            }
         }
      }
      
      private function __titleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if((param1.currentTarget as IMListItemView).getCellValue() == _currentTitleInfo)
         {
            _currentTitleInfo.titleIsSelected = !_currentTitleInfo.titleIsSelected;
         }
         else
         {
            _currentTitleInfo.titleIsSelected = false;
            _currentTitleInfo = (param1.currentTarget as IMListItemView).getCellValue();
            _currentTitleInfo.titleIsSelected = true;
         }
         _title.setCellValue(_titleInfo);
         _titleII.setCellValue(_titleInfoII);
         updateList();
         updatePageBtnState();
         dispatchEvent(new Event("change"));
      }
      
      private function updateList() : void
      {
         if(_currentTitleInfo.titleType == 0 && _currentTitleInfo.titleIsSelected)
         {
            _list.visible = true;
            updatePlayDDTList();
         }
         else if(_currentTitleInfo.titleType == 1 && _currentTitleInfo.titleIsSelected)
         {
            _list.visible = true;
            updateUnPlayDDTList();
         }
         else if(!_currentTitleInfo.titleIsSelected)
         {
            if(_currentCMFInfo)
            {
               _currentCMFInfo.isSelected = false;
            }
            _list.visible = false;
            updateListPos();
         }
      }
      
      private function updatePlayDDTList() : void
      {
         _CMFriendArray = [];
         _CMFriendArray = PlayerManager.Instance.PlayCMFriendList;
         if(!_CMFriendArray)
         {
            return;
         }
         _playDDTListTotalPage = Math.ceil(_CMFriendArray.length / 5);
         updateItem();
      }
      
      private function updateUnPlayDDTList() : void
      {
         _CMFriendArray = [];
         _CMFriendArray = PlayerManager.Instance.UnPlayCMFriendList;
         if(!_CMFriendArray)
         {
            return;
         }
         _unplayDDTListTotalPage = Math.ceil(_CMFriendArray.length / 5);
         updateItem();
      }
      
      private function creatItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new CMFriendItem();
            _loc1_.addEventListener("click",__itemClick);
            _loc1_.addEventListener("mouseOver",__itemOver);
            _loc1_.addEventListener("mouseOut",__itemOut);
            _list.addChild(_loc1_);
            _CMFriendItemArray.push(_loc1_);
            _loc2_++;
         }
         updateListPos();
      }
      
      private function updateItem() : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc8_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:* = 0;
         if(_currentTitleInfo.titleType == 0)
         {
            _loc6_ = _playCurrentPage * 5;
            _loc3_ = _playCurrentPage * 5 + 5 - 1;
            _loc1_ = 0;
            _loc8_ = _loc6_;
            while(_loc8_ <= _loc3_)
            {
               if(_CMFriendArray[_loc8_] as CMFriendInfo && _CMFriendItemArray[_loc1_])
               {
                  _CMFriendItemArray[_loc1_].visible = true;
                  _CMFriendItemArray[_loc1_].info = _CMFriendArray[_loc8_] as CMFriendInfo;
               }
               else if(_CMFriendItemArray[_loc1_])
               {
                  _CMFriendItemArray[_loc1_].visible = false;
               }
               _loc1_++;
               _loc8_++;
            }
         }
         else if(_currentTitleInfo.titleType == 1)
         {
            _loc4_ = _unplayCurrentPage * 5;
            _loc5_ = _unplayCurrentPage * 5 + 5 - 1;
            _loc2_ = 0;
            _loc7_ = _loc4_;
            while(_loc7_ <= _loc5_)
            {
               if(_CMFriendArray[_loc7_] as CMFriendInfo && _CMFriendItemArray[_loc1_])
               {
                  _CMFriendItemArray[_loc2_].visible = true;
                  _CMFriendItemArray[_loc2_].info = _CMFriendArray[_loc7_] as CMFriendInfo;
               }
               else if(_CMFriendItemArray[_loc1_])
               {
                  _CMFriendItemArray[_loc2_].visible = false;
               }
               _loc2_++;
               _loc7_++;
            }
         }
         updateListPos();
      }
      
      private function updateListPos() : void
      {
         if(_currentTitleInfo.titleType == 0 && _currentTitleInfo.titleIsSelected)
         {
            _list.y = _title.y + _title.height - 7;
            _titleII.y = _list.y + _list.height - 3;
         }
         else if(_currentTitleInfo.titleType == 1 && _currentTitleInfo.titleIsSelected)
         {
            _titleII.y = _title.y + _title.height - 7;
            _list.y = _titleII.y + _titleII.height - 7;
         }
         else
         {
            _titleII.y = _title.y + _title.height - 7;
         }
      }
      
      private function cleanItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _CMFriendItemArray.length)
         {
            (_CMFriendItemArray[_loc1_] as CMFriendItem).removeEventListener("click",__itemClick);
            (_CMFriendItemArray[_loc1_] as CMFriendItem).removeEventListener("mouseOver",__itemOver);
            (_CMFriendItemArray[_loc1_] as CMFriendItem).removeEventListener("mouseOut",__itemOut);
            (_CMFriendItemArray[_loc1_] as CMFriendItem).dispose();
            _loc1_++;
         }
         _list.disposeAllChildren();
         _CMFriendItemArray = [];
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_currentCMFInfo)
         {
            _currentCMFInfo = (param1.currentTarget as CMFriendItem).info;
            _currentCMFInfo.isSelected = true;
         }
         else
         {
            if(_currentCMFInfo == (param1.currentTarget as CMFriendItem).info)
            {
               return;
            }
            _currentCMFInfo.isSelected = false;
            _currentCMFInfo = (param1.currentTarget as CMFriendItem).info;
            _currentCMFInfo.isSelected = true;
         }
         updateItem();
         dispatchEvent(new Event("change"));
      }
      
      private function __itemOut(param1:MouseEvent) : void
      {
         resetItem();
         (param1.currentTarget as CMFriendItem).itemOut();
      }
      
      private function __itemOver(param1:MouseEvent) : void
      {
         resetItem();
         (param1.currentTarget as CMFriendItem).itemOver();
      }
      
      private function resetItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _CMFriendItemArray.length)
         {
            (_CMFriendItemArray[_loc1_] as CMFriendItem).itemOut();
            _loc1_++;
         }
      }
      
      public function get currentCMFInfo() : CMFriendInfo
      {
         return _currentCMFInfo;
      }
      
      public function get currentTitleInfo() : FriendListPlayer
      {
         return _currentTitleInfo;
      }
      
      protected function __switchBtn1Click(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.autoSnsSend = _switchBtn1.selected;
         if(!_switchBtn1.selected)
         {
            _switchBtn1.tipData = LanguageMgr.GetTranslation("im.CMFriendList.switchBtn1.tipData1");
         }
         else
         {
            _switchBtn1.tipData = LanguageMgr.GetTranslation("im.CMFriendList.switchBtn1.tipData2");
         }
      }
      
      protected function __switchBtn2Click(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.allowSnsSend = _switchBtn2.selected;
         if(!_switchBtn2.selected)
         {
            _switchBtn2.tipData = LanguageMgr.GetTranslation("im.CMFriendList.switchBtn2.tipData1");
         }
         else
         {
            _switchBtn2.tipData = LanguageMgr.GetTranslation("im.CMFriendList.switchBtn2.tipData2");
         }
      }
      
      public function dispose() : void
      {
         cleanItem();
         if(_list && _list.parent)
         {
            _list.parent.removeChild(_list);
            _list.dispose();
            _list = null;
         }
         if(_title && _title.parent)
         {
            _title.removeEventListener("click",__titleClick);
            _title.parent.removeChild(_title);
            _title.dispose();
            _title = null;
         }
         if(_titleII && _titleII.parent)
         {
            _titleII.removeEventListener("click",__titleClick);
            _titleII.parent.removeChild(_titleII);
            _titleII.dispose();
            _titleII = null;
         }
         if(_upPageBtn && _upPageBtn.parent)
         {
            _upPageBtn.removeEventListener("click",__pageBtnClick);
            _upPageBtn.parent.removeChild(_upPageBtn);
            _upPageBtn.dispose();
            _upPageBtn = null;
         }
         if(_downPageBtn && _downPageBtn.parent)
         {
            _downPageBtn.removeEventListener("click",__pageBtnClick);
            _downPageBtn.parent.removeChild(_downPageBtn);
            _downPageBtn.dispose();
            _downPageBtn = null;
         }
         if(_InviteBlogBtn)
         {
            _InviteBlogBtn.removeEventListener("click",__inviteBolg);
            ObjectUtils.disposeObject(_InviteBlogBtn);
            _InviteBlogBtn = null;
         }
         if(_switchBtn1 && _switchBtn1.parent)
         {
            _switchBtn1.removeEventListener("click",__switchBtn1Click);
            _switchBtn1.parent.removeChild(_switchBtn1);
            _switchBtn1.dispose();
            _switchBtn1 = null;
         }
         if(_switchBtn2 && _switchBtn2.parent)
         {
            _switchBtn2.removeEventListener("click",__switchBtn2Click);
            _switchBtn2.parent.removeChild(_switchBtn2);
            _switchBtn2.dispose();
            _switchBtn2 = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
