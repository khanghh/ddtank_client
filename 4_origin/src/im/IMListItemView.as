package im
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.interfaces.IAcceptDrag;
   import ddt.interfaces.IDragable;
   import ddt.manager.ChatManager;
   import ddt.manager.DragManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import vip.VipController;
   
   public class IMListItemView extends Sprite implements IListCell, Disposeable, IDragable, IAcceptDrag
   {
      
      public static var MAX_CHAR:int = 7;
      
      public static const FRIEND_ITEM:int = 0;
      
      public static const TITLE_ITEM:int = 1;
       
      
      private var _titleBG:ScaleFrameImage;
      
      private var _friendBG:ScaleFrameImage;
      
      private var _triangle:ScaleFrameImage;
      
      private var _state:ScaleFrameImage;
      
      private var _isSelected:Boolean;
      
      private var _type:int;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexMoive:MovieClip;
      
      private var _sexIcon:SexIcon;
      
      private var _masterIcon:ScaleFrameImage;
      
      private var _nameText:FilterFrameText;
      
      private var _titleText:FilterFrameText;
      
      private var _numText:FilterFrameText;
      
      private var _info:FriendListPlayer;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      private var _markBtn:SimpleBitmapButton;
      
      private var _snsInviteBtn:SimpleBitmapButton;
      
      private var _deleteBtn:SimpleBitmapButton;
      
      private var _callBackBtn:SimpleBitmapButton;
      
      private var _callBackedBitmap:Bitmap;
      
      private var _vipName:GradientText;
      
      private var _colorMatrixSp:Sprite;
      
      private var _CMFIcon:Image;
      
      private var _iconBitmap:Bitmap;
      
      private var _stateoldx:int;
      
      private var _city:ScaleFrameImage;
      
      private var _customInput:TextInput;
      
      private var _markInput:TextInput;
      
      private var _hasDouble:Boolean = false;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _markBtnClicked:Boolean = false;
      
      public function IMListItemView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         this.buttonMode = true;
         _myColorMatrix_filter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         _colorMatrixSp = new Sprite();
         _titleBG = ComponentFactory.Instance.creat("IM.item.titleItemBg");
         _titleBG.setFrame(1);
         addChild(_titleBG);
         _triangle = ComponentFactory.Instance.creat("IM.item.triangle");
         _triangle.setFrame(1);
         addChild(_triangle);
         _titleText = ComponentFactory.Instance.creat("IM.item.title");
         _titleText.text = "";
         _colorMatrixSp.addChild(_titleText);
         _numText = ComponentFactory.Instance.creat("IM.item.title");
         _numText.text = "";
         _numText.x = _titleText.x + _titleText.width;
         _colorMatrixSp.addChild(_numText);
         _friendBG = ComponentFactory.Instance.creat("IM.item.FriendItemBg");
         _friendBG.setFrame(1);
         _colorMatrixSp.addChild(_friendBG);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("IM.item.levelIcon");
         _levelIcon.setSize(1);
         _colorMatrixSp.addChild(_levelIcon);
         _sexMoive = ClassUtils.CreatInstance("asset.IM.sexMoive") as MovieClip;
         _colorMatrixSp.addChild(_sexMoive);
         PositionUtils.setPos(_sexMoive,"IM.IMListPlayerItemCell.sexIconPos");
         _sexIcon = new SexIcon(false);
         _sexMoive.content.addChild(_sexIcon);
         _masterIcon = ComponentFactory.Instance.creatComponentByStylename("core.im.masterRelationIcon");
         _masterIcon.visible = false;
         _sexMoive.content.addChild(_masterIcon);
         _city = ComponentFactory.Instance.creatComponentByStylename("core.im.CityIcon");
         _sexMoive.content.addChild(_city);
         _sexMoive.gotoAndStop(1);
         addChild(_colorMatrixSp);
         _nameText = ComponentFactory.Instance.creat("IM.item.name");
         _markBtn = ComponentFactory.Instance.creat("IM.friendItem.markBtn");
         _markBtn.tipData = LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.remark");
         _markBtn.visible = false;
         _colorMatrixSp.addChild(_markBtn);
         _snsInviteBtn = ComponentFactory.Instance.creatComponentByStylename("IM.friendItem.snsInviteBtn");
         _snsInviteBtn.tipData = LanguageMgr.GetTranslation("ddt.view.SnsFrame.snsInviteBtnTipData");
         _snsInviteBtn.visible = false;
         addChild(_snsInviteBtn);
         _deleteBtn = ComponentFactory.Instance.creat("IM.friendItem.deleteBtn");
         _deleteBtn.tipData = LanguageMgr.GetTranslation("tank.view.im.IMFriendItem.delete");
         _deleteBtn.visible = false;
         addChild(_deleteBtn);
         _callBackBtn = ComponentFactory.Instance.creat("IM.friendItem.callBackBtn");
         _callBackBtn.tipData = LanguageMgr.GetTranslation("tank.view.im.IMFriendItem.callback");
         addChild(_callBackBtn);
         _callBackedBitmap = ComponentFactory.Instance.creat("asset.IM.callBacked");
         addChild(_callBackedBitmap);
         setCallBackBtnEnable();
         _state = ComponentFactory.Instance.creat("IM.item.FriendState");
         _state.setFrame(1);
         _stateoldx = _state.x;
         addChild(_state);
         if(PathManager.CommunityExist() && IMManager.Instance.icon && IMManager.Instance.icon.bitmapData)
         {
            _iconBitmap = new Bitmap(IMManager.Instance.icon.bitmapData);
            _CMFIcon = new Image();
            _CMFIcon.addChild(_iconBitmap);
            _CMFIcon.tipStyle = "ddt.view.tips.OneLineTip";
            _CMFIcon.tipDirctions = "0,4,5";
            _CMFIcon.tipData = LanguageMgr.GetTranslation("community");
            PositionUtils.setPos(_CMFIcon,"IM.friendItem.CMFIconPos");
            addChild(_CMFIcon);
            _CMFIcon.visible = false;
         }
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      private function setCallBackBtnEnable() : void
      {
         _callBackBtn.visible = PathManager.callBackEnable();
         _callBackedBitmap.visible = !_callBackBtn.visible;
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__itemOver);
         addEventListener("rollOut",__itemOut);
         _snsInviteBtn.addEventListener("mouseDown",__snsInviteBtnClick);
         _deleteBtn.addEventListener("mouseDown",__deleteBtnClick);
         _callBackBtn.addEventListener("mouseDown",_callBackBtnClick);
         addEventListener("interactive_click",__itemClick);
         addEventListener("interactive_double_click",__doubleClickhandler);
         IMControl.Instance.addEventListener("hasNewMessage",__hasNewMessage);
         IMControl.Instance.addEventListener("alertMessage",__alertMessage);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__itemOver);
         removeEventListener("rollOut",__itemOut);
         removeEventListener("interactive_click",__itemClick);
         if(_callBackBtn != null)
         {
            _callBackBtn.removeEventListener("mouseDown",_callBackBtnClick);
         }
         if(_markBtn != null)
         {
            _markBtn.removeEventListener("mouseDown",__markBtnClick);
         }
         if(_snsInviteBtn != null)
         {
            _snsInviteBtn.removeEventListener("click",__snsInviteBtnClick);
         }
         if(_deleteBtn != null)
         {
            _deleteBtn.removeEventListener("mouseDown",__deleteBtnClick);
         }
         removeEventListener("interactive_double_click",__doubleClickhandler);
         IMControl.Instance.removeEventListener("hasNewMessage",__hasNewMessage);
         IMControl.Instance.removeEventListener("alertMessage",__alertMessage);
      }
      
      protected function __alertMessage(param1:Event) : void
      {
         if(info && info.type == 1 && info.ID == IMManager.Instance.changeID)
         {
            _sexMoive.gotoAndStop(1);
         }
      }
      
      protected function __hasNewMessage(param1:Event) : void
      {
         if(info && info.type == 1 && info.ID == IMManager.Instance.changeID)
         {
            _sexMoive.gotoAndPlay(1);
         }
      }
      
      protected function __doubleClickhandler(param1:InteractiveEvent) : void
      {
         if(info.type == 0 && info.titleType >= 10)
         {
            createCustomInput();
            _hasDouble = true;
         }
         if(info.type == 1 && info.Relation != 1)
         {
            IMManager.Instance.alertPrivateFrame(info.ID);
         }
      }
      
      protected function __customInputHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function _callBackBtnClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(_callBackBtn.enable == true)
         {
            SocketManager.Instance.out.sendRegressCall(info.ID);
            (parent.parent.parent.parent as IMListView).currentItem = this;
         }
      }
      
      private function __deleteBtnClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(info.type == 0)
         {
            IMManager.Instance.deleteGroup(info.titleType,info.titleText);
         }
         else if(IMControl.Instance.titleType != 1 && IMControl.Instance.titleType != 2)
         {
            IMManager.Instance.deleteFriend(info.ID);
         }
         else if(IMControl.Instance.titleType == 1)
         {
            IMManager.Instance.deleteFriend(info.ID,true);
         }
         else
         {
            IMManager.Instance.deleteRecentContacts(info.ID);
         }
      }
      
      private function __privateChatBtnClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         ChatManager.Instance.privateChatTo(info.NickName,info.ID,info);
         ChatManager.Instance.setFocus();
      }
      
      private function __markBtnClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         (parent.parent.parent.parent as IMListView).currentItem = this;
         _markBtnClicked = true;
         SoundManager.instance.play("008");
         createMarkInput();
      }
      
      protected function __snsInviteBtnClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         var _loc3_:InviteDialogFrame = ComponentFactory.Instance.creatComponentByStylename("InviteDialogFrame");
         _loc3_.setInfo(info.UserName);
         var _loc2_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.view.SnsFrame.snsInviteBtnTipData"));
         _loc2_.showCancel = false;
         _loc3_.info = _loc2_;
         _loc3_.setText(LanguageMgr.GetTranslation("ddt.view.SnsFrame.inputTextText"));
         _loc3_.show();
      }
      
      private function __itemClick(param1:InteractiveEvent) : void
      {
         if(_markBtnClicked)
         {
            return;
         }
         if(!(param1.target is SimpleBitmapButton) && info.type == 1 && info.Relation != 1)
         {
            SoundManager.instance.play("008");
            IMManager.isInIM = true;
            PlayerTipManager.show(info,localToGlobal(new Point(0,0)).y);
            _deleteBtn.visible = false;
            _markBtn.visible = false;
            _snsInviteBtn.visible = false;
            if(_CMFIcon)
            {
               _CMFIcon.visible = false;
            }
         }
         if(info.titleType == 3)
         {
            _triangle.visible = false;
            _numText.visible = false;
            _titleText.visible = false;
            createCustomInput();
         }
      }
      
      public function onMarkClick(param1:CEvent) : void
      {
         var _loc2_:String = param1.data as String;
         if(_info && _loc2_ != _info.NickName)
         {
            _info.Mark = _loc2_;
            _info.Mark = FilterWordManager.filterWrod(_info.Mark);
            if(_info.Mark == "")
            {
               _nameText.text = _info.NickName;
            }
            else
            {
               _nameText.text = _info.Mark;
            }
            updateItem();
            SocketManager.Instance.out.sendMark(_info.ID,_info.Mark);
         }
      }
      
      private function createCustomInput() : void
      {
         if(_customInput == null)
         {
            _customInput = ComponentFactory.Instance.creatComponentByStylename("IM.item.customInput");
            _customInput.maxChars = MAX_CHAR;
            addChild(_customInput);
            _customInput.addEventListener("keyDown",__keyDownHandler);
            _customInput.addEventListener("click",__customInputHandler);
            _customInput.addEventListener("focusOut",__fucksOutHandler);
         }
         _customInput.setFocus();
      }
      
      private function createMarkInput() : void
      {
         var _loc1_:MarkFrame = ComponentFactory.Instance.creatComponentByStylename("IM.markFrame");
         LayerManager.Instance.addToLayer(_loc1_,7,true,1);
      }
      
      private function __itemOver(param1:MouseEvent) : void
      {
         if(!info.titleIsSelected)
         {
            _titleBG.setFrame(2);
            _friendBG.setFrame(2);
         }
         if(info.type == 1)
         {
            _deleteBtn.visible = true;
            if(info.Relation == 1)
            {
               _markBtn.visible = false;
               _snsInviteBtn.visible = false;
            }
            else if(PathManager.CommunityExist())
            {
               _markBtn.visible = true;
               if(info.playerState.StateID == 0 && info.type != 0)
               {
                  _markBtn.visible = false;
                  if(PathManager.CommunityFriendInvitedOnlineSwitch())
                  {
                     _snsInviteBtn.visible = true;
                  }
                  else
                  {
                     _snsInviteBtn.visible = false;
                  }
               }
               else
               {
                  _markBtn.visible = true;
                  _snsInviteBtn.visible = false;
               }
               if(_CMFIcon && info.BBSFriends && _state.visible)
               {
                  _CMFIcon.visible = true;
               }
            }
            else
            {
               _markBtn.visible = true;
               _markBtn.addEventListener("mouseDown",__markBtnClick);
            }
         }
         else if(info.type == 0)
         {
            if(info.titleType >= 10)
            {
               _deleteBtn.visible = true;
            }
         }
      }
      
      private function __itemOut(param1:MouseEvent) : void
      {
         if(!info.titleIsSelected)
         {
            _titleBG.setFrame(1);
            _friendBG.setFrame(1);
         }
         _deleteBtn.visible = false;
         _markBtn.visible = false;
         _markBtn.removeEventListener("mouseDown",__markBtnClick);
         _snsInviteBtn.visible = false;
         if(_CMFIcon && info.BBSFriends)
         {
            _CMFIcon.visible = false;
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return info;
      }
      
      public function setCellValue(param1:*) : void
      {
         info = param1;
         update();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function update() : void
      {
         clearCustomInput();
         clearMarkInput();
         if(info.type == 0)
         {
            var _loc1_:Boolean = false;
            _callBackedBitmap.visible = _loc1_;
            _callBackBtn.visible = _loc1_;
            updateTilte();
         }
         else if(info.type == 1)
         {
            _callBackBtn.visible = PathManager.callBackEnable();
            _callBackBtn.enable = info.callBtnEnable;
            _callBackedBitmap.visible = !_callBackBtn.visible;
            updateItem();
         }
         else
         {
            _loc1_ = false;
            _callBackedBitmap.visible = _loc1_;
            _callBackBtn.visible = _loc1_;
            updateBtn();
         }
         updateItemState();
      }
      
      private function updateTilte() : void
      {
         DisplayUtils.removeDisplay(_nameText,_vipName);
         PositionUtils.setPos(_deleteBtn,"ListItemView.titleDeletePos");
         _sexMoive.visible = false;
         _sexMoive.gotoAndStop(1);
         if(_attestBtn != null)
         {
            _attestBtn.visible = false;
         }
         var _loc1_:* = true;
         _triangle.visible = _loc1_;
         _loc1_ = _loc1_;
         _numText.visible = _loc1_;
         _titleText.visible = _loc1_;
         _loc1_ = false;
         _sexIcon.visible = _loc1_;
         _loc1_ = _loc1_;
         _levelIcon.visible = _loc1_;
         _loc1_ = _loc1_;
         _friendBG.visible = _loc1_;
         _state.visible = _loc1_;
         _loc1_ = false;
         _city.visible = _loc1_;
         _markBtn.visible = _loc1_;
         _loc1_ = false;
         _masterIcon.visible = _loc1_;
         _loc1_ = _loc1_;
         _snsInviteBtn.visible = _loc1_;
         _deleteBtn.visible = _loc1_;
         _titleBG.visible = true;
         _titleBG.setFrame(!!info.titleIsSelected?1:3);
         _titleText.x = 20;
         _titleText.text = info.titleText;
         _numText.text = info.titleNumText;
         _numText.x = _titleText.x + _titleText.width;
         this.filters = null;
      }
      
      private function clearCustomInput() : void
      {
         if(_customInput)
         {
            _customInput.removeEventListener("keyDown",__keyDownHandler);
            _customInput.removeEventListener("click",__customInputHandler);
            _customInput.removeEventListener("focusOut",__fucksOutHandler);
            ObjectUtils.disposeObject(_customInput);
         }
         _customInput = null;
      }
      
      private function clearMarkInput() : void
      {
         if(_markInput)
         {
            _markInput.removeEventListener("keyDown",__keyDownHandler);
            _markInput.removeEventListener("click",__customInputHandler);
            _markInput.removeEventListener("focusOut",__markOutHandler);
            ObjectUtils.disposeObject(_markInput);
         }
         _markInput = null;
         _markBtnClicked = false;
      }
      
      protected function __fucksOutHandler(param1:FocusEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_customInput)
         {
            info.titleIsSelected = false;
            if(_hasDouble)
            {
               if(_customInput.text != "" && !PlayerManager.Instance.checkHasGroupName(_customInput.text))
               {
                  SocketManager.Instance.out.sendCustomFriends(3,info.titleType,_customInput.text);
                  _hasDouble = false;
               }
            }
            else
            {
               _titleText.visible = true;
               if(_customInput.text != "" && !PlayerManager.Instance.checkHasGroupName(_customInput.text))
               {
                  _loc4_ = PlayerManager.Instance.customList;
                  if(_loc4_.length >= 10 + 2)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.MaxCustom"));
                  }
                  else
                  {
                     _loc2_ = 10;
                     _loc3_ = 1;
                     while(_loc3_ < _loc4_.length - 1)
                     {
                        if(_loc4_[_loc3_].ID != 9 + _loc3_)
                        {
                           _loc2_ = 9 + _loc3_;
                           break;
                        }
                        if(_loc3_ == _loc4_.length - 2)
                        {
                           _loc2_ = 10 + _loc3_;
                        }
                        _loc3_++;
                     }
                     SocketManager.Instance.out.sendCustomFriends(1,_loc2_,_customInput.text);
                  }
               }
            }
            clearCustomInput();
         }
      }
      
      protected function __markOutHandler(param1:FocusEvent) : void
      {
         if(_markInput)
         {
            info.titleIsSelected = false;
            if(_hasDouble)
            {
               _markInput.text = _markInput.text.replace(" ","");
               if(_markInput.text != "" && !PlayerManager.Instance.checkHasGroupName(_markInput.text))
               {
                  SocketManager.Instance.out.sendCustomFriends(3,info.titleType,_markInput.text);
                  _hasDouble = false;
               }
            }
            else
            {
               _titleText.visible = true;
               if(_markInput.text != "" && _info && _markInput.text != _info.NickName)
               {
                  _info.Mark = _markInput.text;
                  _nameText.text = _info.Mark;
                  updateItem();
                  SocketManager.Instance.out.sendMark(_info.ID,_markInput.text);
               }
            }
            clearMarkInput();
         }
         _markBtnClicked = false;
      }
      
      protected function __keyDownHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         if(param1.keyCode == 13)
         {
            SoundManager.instance.play("008");
            if(_customInput != null)
            {
               __fucksOutHandler(null);
            }
            else if(_markInput != null)
            {
               __markOutHandler(null);
            }
         }
      }
      
      private function updateBtn() : void
      {
         var _loc1_:* = false;
         _triangle.visible = _loc1_;
         _loc1_ = _loc1_;
         _numText.visible = _loc1_;
         _loc1_ = _loc1_;
         _titleText.visible = _loc1_;
         _titleBG.visible = _loc1_;
         _loc1_ = false;
         _masterIcon.visible = _loc1_;
         _loc1_ = _loc1_;
         _snsInviteBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _deleteBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _markBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _sexIcon.visible = _loc1_;
         _loc1_ = _loc1_;
         _levelIcon.visible = _loc1_;
         _loc1_ = _loc1_;
         _friendBG.visible = _loc1_;
         _state.visible = _loc1_;
         DisplayUtils.removeDisplay(_nameText,_vipName);
      }
      
      private function updateItem() : void
      {
         _sexMoive.visible = true;
         if(IMControl.Instance.checkHasNew(info.ID))
         {
            _sexMoive.gotoAndPlay(1);
         }
         else
         {
            _sexMoive.gotoAndStop(1);
         }
         PositionUtils.setPos(_deleteBtn,"ListItemView.ItemDeletePos");
         var _loc3_:* = true;
         _city.visible = _loc3_;
         _loc3_ = _loc3_;
         _sexIcon.visible = _loc3_;
         _loc3_ = _loc3_;
         _levelIcon.visible = _loc3_;
         _loc3_ = _loc3_;
         _friendBG.visible = _loc3_;
         _state.visible = _loc3_;
         _masterIcon.visible = PlayerManager.Instance.Self.isMyApprent(info.ID) || PlayerManager.Instance.Self.isMyMaster(info.ID);
         _city.visible = !_masterIcon.visible && info.isSameCity;
         _sexIcon.visible = !_masterIcon.visible && !_city.visible;
         if(info.isSameCity && info.playerState.StateID != 0)
         {
            if(info.Sex)
            {
               _city.setFrame(1);
            }
            else
            {
               _city.setFrame(2);
            }
         }
         else
         {
            _city.visible = false;
         }
         if(PlayerManager.Instance.Self.isMyMaster(info.ID))
         {
            if(info.Sex)
            {
               _masterIcon.setFrame(1);
            }
            else
            {
               _masterIcon.setFrame(2);
            }
         }
         else if(info.Sex)
         {
            _masterIcon.setFrame(3);
         }
         else
         {
            _masterIcon.setFrame(4);
         }
         switch(int(info.playerState.StateID))
         {
            case 0:
            case 1:
               _state.visible = false;
               break;
            case 2:
               _state.setFrame(1);
               break;
            case 3:
               _state.setFrame(2);
               break;
            case 4:
               _state.setFrame(4);
               break;
            case 5:
               _state.setFrame(3);
               break;
            case 6:
               _state.setFrame(5);
         }
         _loc3_ = false;
         _triangle.visible = _loc3_;
         _loc3_ = _loc3_;
         _numText.visible = _loc3_;
         _loc3_ = _loc3_;
         _titleText.visible = _loc3_;
         _titleBG.visible = _loc3_;
         _friendBG.setFrame(1);
         _levelIcon.setInfo(info.Grade,info.ddtKingGrade,info.Repute,info.WinCount,info.TotalCount,info.FightPower,info.Offer,true);
         _sexIcon.x = _levelIcon.x + _levelIcon.width + 2;
         _sexIcon.setSex(info.Sex);
         _masterIcon.x = _sexIcon.x;
         ObjectUtils.disposeObject(_nameText);
         _nameText = ComponentFactory.Instance.creat("IM.item.name");
         _nameText.x = _sexIcon.x + _sexIcon.width + 2;
         _nameText.text = info.Mark == ""?info.NickName:info.Mark;
         _colorMatrixSp.addChild(_nameText);
         if(info.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(129,info.typeVIP);
            _vipName.x = _nameText.x;
            _vipName.y = _nameText.y;
            _vipName.text = _nameText.text;
            _colorMatrixSp.addChild(_vipName);
         }
         PositionUtils.adaptNameStyle(info,_nameText,_vipName);
         if(info.playerState.StateID == 0 && info.type != 0)
         {
            _colorMatrixSp.filters = [_myColorMatrix_filter];
         }
         else
         {
            _colorMatrixSp.filters = null;
         }
         if(info.Relation == 1)
         {
            this.buttonMode = false;
            _colorMatrixSp.filters = [_myColorMatrix_filter];
         }
         _state.x = _nameText.x + _nameText.width + _stateoldx;
         if(_state.visible)
         {
            _markBtn.visible = false;
         }
         updateMasetrIcon();
         var _loc1_:Array = PlayerManager.Instance.getOnlineFriendForCustom(0);
         var _loc2_:Date = TimeManager.Instance.serverDate;
         if(info.Relation == 1 || info.Grade < 15)
         {
            _callBackBtn.visible = false;
            _callBackedBitmap.visible = false;
         }
         else if(info.LastLoginDate == null || _loc2_.time - info.LastLoginDate.time < 2592000000)
         {
            _callBackBtn.visible = false;
            _callBackedBitmap.visible = false;
         }
         else if(_loc1_.indexOf(info) != -1)
         {
            _callBackBtn.visible = false;
            _callBackedBitmap.visible = false;
         }
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(info.isAttest)
         {
            if(_attestBtn == null)
            {
               _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
               _colorMatrixSp.addChild(_attestBtn);
               _attestBtn.x = _sexMoive.x + 27;
               _attestBtn.y = _sexMoive.y - 4;
            }
            _sexMoive.visible = false;
            _attestBtn.visible = true;
         }
         else
         {
            _sexMoive.visible = true;
            if(_attestBtn != null)
            {
               _attestBtn.visible = false;
            }
         }
      }
      
      private function updateMasetrIcon() : void
      {
         var _loc1_:SelfInfo = PlayerManager.Instance.Self;
      }
      
      private function updateItemState() : void
      {
         if(info.titleIsSelected)
         {
            setItemSelectedState(true);
         }
         else
         {
            setItemSelectedState(false);
         }
      }
      
      private function setItemSelectedState(param1:Boolean) : void
      {
         if(param1)
         {
            _triangle.setFrame(2);
            _titleBG.setFrame(3);
            _friendBG.setFrame(3);
         }
         else
         {
            _triangle.setFrame(1);
            _titleBG.setFrame(1);
            _friendBG.setFrame(1);
         }
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function dragStop(param1:DragEffect) : void
      {
         var _loc4_:Boolean = false;
         var _loc3_:IMListItemView = param1.target as IMListItemView;
         var _loc2_:FriendListPlayer = param1.data as FriendListPlayer;
         var _loc5_:FriendListPlayer = _loc3_.getCellValue() as FriendListPlayer;
         if(_loc3_ && _loc5_ && _loc5_.type == 0 && (_loc5_.titleType >= 10 || _loc5_.titleType == 0))
         {
            if(_loc2_.Relation == 1)
            {
               IMManager.Instance.addFriend(_loc2_.NickName);
            }
            else
            {
               _loc4_ = PlayerManager.Instance.hasInFriendList(_loc2_.ID);
               if(_loc4_ || !_loc4_ && !IMManager.Instance.isMaxFriend())
               {
                  SocketManager.Instance.out.sendAddFriend(_loc2_.NickName,_loc5_.titleType);
               }
            }
         }
         param1.action = "none";
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         if(info.type == 0)
         {
            DragManager.acceptDrag(this,"none");
         }
      }
      
      public function dragStart() : void
      {
         if(info && info.type == 1)
         {
            DragManager.startDrag(this,info,createImg(),stage.mouseX,stage.mouseY,"move",true,false,false,false);
            dispatchEvent(new CellEvent("dragStart"));
         }
      }
      
      private function createImg() : DisplayObject
      {
         var _loc1_:Bitmap = new Bitmap(new BitmapData(width,height,false,0),"auto",true);
         _loc1_.bitmapData.draw(_colorMatrixSp);
         return _loc1_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_colorMatrixSp)
         {
            if(_colorMatrixSp.parent)
            {
               _colorMatrixSp.parent.removeChild(_colorMatrixSp);
            }
            _colorMatrixSp = null;
            _myColorMatrix_filter = null;
         }
         if(_city)
         {
            ObjectUtils.disposeObject(_city);
            _city = null;
         }
         if(_titleBG)
         {
            _titleBG.dispose();
            _titleBG = null;
         }
         if(_friendBG)
         {
            _friendBG.dispose();
            _friendBG = null;
         }
         if(_triangle)
         {
            _triangle.dispose();
            _triangle = null;
         }
         if(_levelIcon)
         {
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_sexIcon)
         {
            _sexIcon.dispose();
            _sexIcon = null;
         }
         if(_masterIcon)
         {
            _masterIcon.dispose();
            _masterIcon = null;
         }
         if(_nameText)
         {
            _nameText.dispose();
            _nameText = null;
         }
         if(_titleText)
         {
            _titleText.dispose();
            _titleText = null;
         }
         if(_numText)
         {
            _numText.dispose();
            _numText = null;
         }
         if(_markBtn)
         {
            _markBtn.dispose();
            _markBtn = null;
         }
         if(_snsInviteBtn)
         {
            _snsInviteBtn.dispose();
            _snsInviteBtn = null;
         }
         if(_deleteBtn)
         {
            _deleteBtn.dispose();
            _deleteBtn = null;
         }
         if(_CMFIcon)
         {
            _CMFIcon.dispose();
            _CMFIcon = null;
         }
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = null;
         }
         if(_state)
         {
            ObjectUtils.disposeObject(_state);
            _state = null;
         }
         if(_callBackBtn)
         {
            ObjectUtils.disposeObject(_callBackBtn);
            _callBackBtn = null;
         }
         if(_attestBtn)
         {
            ObjectUtils.disposeObject(_attestBtn);
            _attestBtn = null;
         }
         if(_callBackedBitmap)
         {
            _callBackedBitmap = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get callBackBtn() : SimpleBitmapButton
      {
         return _callBackBtn;
      }
      
      public function set callBackBtn(param1:SimpleBitmapButton) : void
      {
         _callBackBtn = param1;
      }
      
      public function get info() : FriendListPlayer
      {
         return _info;
      }
      
      public function set info(param1:FriendListPlayer) : void
      {
         _info = param1;
      }
   }
}
