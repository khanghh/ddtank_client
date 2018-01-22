package im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import vip.VipController;
   
   public class ConsortiaListItemView extends Sprite implements IListCell, Disposeable
   {
       
      
      private var _friendBG:ScaleFrameImage;
      
      private var _isSelected:Boolean;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexIcon:SexIcon;
      
      private var _nameText:FilterFrameText;
      
      private var _info;
      
      private var _privateChatBtn:SimpleBitmapButton;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      private var _vipName:GradientText;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _titleText:FilterFrameText;
      
      private var _triangle:ScaleFrameImage;
      
      public function ConsortiaListItemView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         this.buttonMode = true;
         _myColorMatrix_filter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         _friendBG = ComponentFactory.Instance.creat("IM.item.FriendItemBg");
         _friendBG.setFrame(1);
         addChild(_friendBG);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("IM.item.levelIcon");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _sexIcon = new SexIcon(false);
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("IM.IMListPlayerItemCell.sexIconPos");
         _sexIcon.x = _loc1_.x;
         _sexIcon.y = _loc1_.y;
         addChild(_sexIcon);
         _nameText = ComponentFactory.Instance.creat("IM.item.name");
         _nameText.text = "";
         addChild(_nameText);
         _privateChatBtn = ComponentFactory.Instance.creat("IM.ConsortiaListItem.privateChatBtn");
         _privateChatBtn.tipData = LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.private");
         _privateChatBtn.visible = false;
         addChild(_privateChatBtn);
         _triangle = ComponentFactory.Instance.creat("IM.item.triangle");
         _triangle.setFrame(1);
         addChild(_triangle);
         _titleText = ComponentFactory.Instance.creat("IM.item.title");
         _titleText.text = "";
         _titleText.x = _triangle.width + 8;
         addChild(_titleText);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__itemOver);
         addEventListener("mouseOut",__itemOut);
         addEventListener("click",__itemClick);
         _privateChatBtn.addEventListener("click",__privateChatBtnClick);
      }
      
      private function __privateChatBtnClick(param1:MouseEvent) : void
      {
         ChatManager.Instance.privateChatTo(_info.NickName,_info.ID);
         ChatManager.Instance.setFocus();
         SoundManager.instance.play("008");
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         if(!(param1.target is SimpleBitmapButton) && _info.type == 1)
         {
            PlayerTipManager.show(_info,localToGlobal(new Point(0,0)).y);
            SoundManager.instance.play("008");
         }
      }
      
      private function __itemOver(param1:MouseEvent) : void
      {
         if(!_info.isSelected)
         {
            _friendBG.setFrame(2);
         }
         if(_info.type == 1)
         {
            _privateChatBtn.visible = true;
         }
         else
         {
            _privateChatBtn.visible = false;
         }
      }
      
      private function __itemOut(param1:MouseEvent) : void
      {
         if(!_info.isSelected)
         {
            _friendBG.setFrame(1);
         }
         _privateChatBtn.visible = false;
      }
      
      private function updateTitle() : void
      {
         DisplayUtils.removeDisplay(_nameText,_vipName);
         if(_attestBtn != null)
         {
            _attestBtn.visible = false;
         }
         var _loc1_:* = true;
         _triangle.visible = _loc1_;
         _titleText.visible = _loc1_;
         _titleText.text = _info.RatifierName;
         _loc1_ = false;
         _sexIcon.visible = _loc1_;
         _loc1_ = _loc1_;
         _levelIcon.visible = _loc1_;
         _friendBG.visible = _loc1_;
         this.filters = null;
      }
      
      private function update() : void
      {
         var _loc1_:* = false;
         _triangle.visible = _loc1_;
         _titleText.visible = _loc1_;
         _loc1_ = true;
         _sexIcon.visible = _loc1_;
         _loc1_ = _loc1_;
         _levelIcon.visible = _loc1_;
         _friendBG.visible = _loc1_;
         if(_info.isSelected)
         {
            _friendBG.setFrame(3);
         }
         else
         {
            _friendBG.setFrame(1);
         }
         _levelIcon.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true);
         _sexIcon.setSex(_info.Sex);
         _sexIcon.x = _levelIcon.x + _levelIcon.width + 2;
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
         }
         _nameText = ComponentFactory.Instance.creat("IM.item.name");
         _nameText.text = _info.NickName;
         _nameText.x = _sexIcon.x + _sexIcon.width + 2;
         if(_info.playerState.StateID == 0)
         {
            this.filters = [_myColorMatrix_filter];
         }
         else
         {
            this.filters = null;
         }
         if(_info.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(139,_info.typeVIP);
            _vipName.x = _nameText.x;
            _vipName.y = _nameText.y;
            _vipName.text = _nameText.text;
            addChild(_vipName);
         }
         addChild(_nameText);
         PositionUtils.adaptNameStyle(_info,_nameText,_vipName);
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(_info.isAttest)
         {
            if(_attestBtn == null)
            {
               _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
               addChild(_attestBtn);
               _attestBtn.x = _sexIcon.x - 3;
               _attestBtn.y = _sexIcon.y - 4;
            }
            _sexIcon.visible = false;
            _attestBtn.visible = true;
         }
         else
         {
            _sexIcon.visible = true;
            if(_attestBtn != null)
            {
               _attestBtn.visible = false;
            }
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(param1:*) : void
      {
         _info = param1;
         if(_info.type == 1)
         {
            update();
         }
         else
         {
            updateTitle();
         }
         updateItemState();
      }
      
      private function updateItemState() : void
      {
         if(_info.isSelected)
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
            _friendBG.setFrame(3);
         }
         else
         {
            _triangle.setFrame(1);
            _friendBG.setFrame(1);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         if(_triangle)
         {
            _triangle.dispose();
            _triangle = null;
         }
         if(_titleText)
         {
            _titleText.dispose();
            _titleText = null;
         }
         if(_friendBG)
         {
            _friendBG.dispose();
            _friendBG = null;
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
         if(_nameText)
         {
            _nameText.dispose();
            _nameText = null;
         }
         if(_privateChatBtn)
         {
            _privateChatBtn.dispose();
            _privateChatBtn = null;
         }
         if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         _myColorMatrix_filter = null;
      }
   }
}
