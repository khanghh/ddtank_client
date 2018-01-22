package cardSystem.view.achievement
{
   import cardSystem.CardManager;
   import cardSystem.data.CardAchievementInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import newTitle.NewTitleManager;
   import newTitle.model.NewTitleModel;
   import road7th.DDTAssetManager;
   
   public class CardAchievementItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private const propertyValue:Array = ["attack","defence","luck","damage","recovery","magicAttack","magicDefend","MaxHp"];
      
      private var _info:CardAchievementInfo;
      
      private var _bg:Bitmap;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _light:Bitmap;
      
      private var _awardBg:Bitmap;
      
      private var _completeIcon:Bitmap;
      
      private var _taskTitle:FilterFrameText;
      
      private var _taskContent:FilterFrameText;
      
      private var _newTitleBg:Bitmap;
      
      private var _titleText:FilterFrameText;
      
      private var _titleImage:Bitmap;
      
      private var _progressLabel:FilterFrameText;
      
      private var _progressText:FilterFrameText;
      
      private var _progress:MovieClip;
      
      private var _propertyTextList:Vector.<CardAchievementItemProperty>;
      
      public function CardAchievementItem()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _propertyTextList = new Vector.<CardAchievementItemProperty>(4);
         _bg = ComponentFactory.Instance.creatBitmap("asset.cardAchievement.itemBg");
         addChild(_bg);
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.itemGetBtnBg");
         addChild(_getBtn);
         _awardBg = ComponentFactory.Instance.creatBitmap("asset.cardAchievement.award");
         addChild(_awardBg);
         _completeIcon = ComponentFactory.Instance.creatBitmap("asset.cardAchievement.complete");
         addChild(_completeIcon);
         _newTitleBg = ComponentFactory.Instance.creatBitmap("asset.cardAchievement.title");
         addChild(_newTitleBg);
         _taskTitle = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.itemTaskTitle");
         addChild(_taskTitle);
         _taskContent = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.itemTaskContent");
         addChild(_taskContent);
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.itemProgressLabel");
         _progressLabel.text = LanguageMgr.GetTranslation("progress");
         addChild(_progressLabel);
         _progressText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.itemProgressText");
         addChild(_progressText);
         _progress = ComponentFactory.Instance.creat("asset.cardAchievement.itemProgress");
         PositionUtils.setPos(_progress,"ddt.cardAchievement.itemProgressPos");
         addChild(_progress);
         _light = ComponentFactory.Instance.creatBitmap("asset.cardAchievement.light");
         _light.visible = false;
         addChild(_light);
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",__onClickGet);
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
         var _loc2_:CardAchievementInfo = param1 as CardAchievementInfo;
         if(_info && _info.AchievementID == _loc2_.AchievementID)
         {
            return;
         }
         _info = _loc2_;
         update();
      }
      
      private function update() : void
      {
         _taskTitle.text = _info.Name;
         _taskContent.text = _info.Desc;
         if(_taskContent.numLines > 1)
         {
            _taskContent.y = 33;
         }
         else
         {
            _taskContent.y = 47;
         }
         updateProgress();
         updateTitle();
         updateProperty();
      }
      
      private function updateProgress() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         if(CardManager.Instance.cardAchievementGet(_info.AchievementID))
         {
            _completeIcon.visible = true;
            _getBtn.visible = false;
            _progressLabel.visible = false;
            _progressText.visible = false;
            _progress.visible = false;
            _light.visible = false;
         }
         else if(CardManager.Instance.cardAchievementComplete(_info.AchievementID))
         {
            _getBtn.visible = true;
            _light.visible = true;
            _getBtn.mouseEnabled = true;
            _completeIcon.visible = false;
            _progressLabel.visible = false;
            _progressText.visible = false;
            _progress.visible = false;
         }
         else
         {
            _light.visible = false;
            _completeIcon.visible = false;
            _getBtn.visible = false;
            _progressLabel.visible = true;
            _progressText.visible = true;
            _progress.visible = true;
            _loc2_ = 0;
            _loc3_ = 0;
            if(_info.RequireNum > 0)
            {
               _loc2_ = _info.RequireNum;
               _loc3_ = PlayerManager.Instance.Self.getCardNumByType(_info.RequireType);
            }
            else if(_info.RequireGroupid > 0)
            {
               _loc2_ = CardManager.Instance.getCardSuitByID(_info.RequireGroupid).cardIdVec.length;
               _loc3_ = PlayerManager.Instance.Self.getCurrentCardSetsNum(_info.RequireGroupid,_info.RequireType);
            }
            else if(_info.RequireGroupNum > 0)
            {
               _loc2_ = _info.RequireGroupNum;
               _loc3_ = PlayerManager.Instance.Self.gainCardSetsNum(_info.RequireType);
            }
            _progressText.text = _loc3_ + "/" + _loc2_;
            _loc1_ = _loc3_ / _loc2_ * 100;
            _progress.gotoAndStop(_loc1_);
         }
      }
      
      private function updateTitle() : void
      {
         var _loc1_:* = null;
         if(_info.Honor_id == 0)
         {
            if(_titleImage)
            {
               _titleImage.visible = false;
            }
            if(_titleText)
            {
               _titleText.visible = false;
            }
            _newTitleBg.visible = false;
         }
         else
         {
            _newTitleBg.visible = true;
            _loc1_ = NewTitleManager.instance.titleInfo[_info.Honor_id];
            if(_loc1_ && _loc1_.Pic && _loc1_.Pic != "0")
            {
               ObjectUtils.disposeObject(_titleImage);
               _titleImage = DDTAssetManager.instance.nativeAsset.getBitmap("image_title_" + _loc1_.Pic);
               _titleImage.x = 381;
               _titleImage.y = 110 - _titleImage.height;
               addChild(_titleImage);
               if(_titleImage)
               {
                  _titleImage.visible = true;
               }
               if(_titleText)
               {
                  _titleText.visible = false;
               }
            }
            else
            {
               if(_titleImage)
               {
                  _titleImage.visible = false;
               }
               if(_titleText)
               {
                  _titleText.visible = true;
               }
            }
         }
      }
      
      private function updateProperty() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = getCurrentProperty();
         _loc2_ = 0;
         while(_loc2_ < _propertyTextList.length)
         {
            if(_loc2_ < _loc1_.length)
            {
               if(_propertyTextList[_loc2_] == null)
               {
                  _propertyTextList[_loc2_] = new CardAchievementItemProperty();
               }
               _propertyTextList[_loc2_].x = 90 * _loc2_;
               _propertyTextList[_loc2_].updateProperty(_loc1_[_loc2_].type,_loc1_[_loc2_].value);
               _propertyTextList[_loc2_].visible = true;
               addChild(_propertyTextList[_loc2_]);
            }
            else if(_propertyTextList[_loc2_])
            {
               _propertyTextList[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      private function getCurrentProperty() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < propertyValue.length)
         {
            if(_info.hasOwnProperty(propertyValue[_loc3_]) && _info[propertyValue[_loc3_]] > 0)
            {
               _loc2_ = {
                  "type":propertyValue[_loc3_],
                  "value":_info[propertyValue[_loc3_]]
               };
               _loc1_.push(_loc2_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function __onClickGet(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _getBtn.mouseEnabled = false;
         SocketManager.Instance.out.sendCardAchievementType(_info.Type);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",__onClickGet);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(_propertyTextList.length)
         {
            ObjectUtils.disposeObject(_propertyTextList.pop());
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_awardBg);
         _awardBg = null;
         ObjectUtils.disposeObject(_completeIcon);
         _completeIcon = null;
         ObjectUtils.disposeObject(_taskTitle);
         _taskTitle = null;
         ObjectUtils.disposeObject(_taskContent);
         _taskContent = null;
         ObjectUtils.disposeObject(_newTitleBg);
         _newTitleBg = null;
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_progressLabel);
         _progressLabel = null;
         ObjectUtils.disposeObject(_progressText);
         _progressText = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         _propertyTextList = null;
         _info = null;
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import ddt.manager.LanguageMgr;
import flash.display.Sprite;

class CardAchievementItemProperty extends Sprite implements Disposeable
{
    
   
   private var _propertyText:FilterFrameText;
   
   private var _propertyValue:FilterFrameText;
   
   function CardAchievementItemProperty()
   {
      super();
      _propertyText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.itemPropertyLabel");
      _propertyValue = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.itemPropertyText");
      addChild(_propertyText);
      addChild(_propertyValue);
   }
   
   public function updateProperty(param1:String, param2:String) : void
   {
      _propertyText.text = LanguageMgr.GetTranslation(param1);
      _propertyValue.text = "+" + param2;
      _propertyValue.x = _propertyText.width + 60;
   }
   
   public function dispose() : void
   {
      ObjectUtils.disposeAllChildren(this);
      _propertyValue = null;
      _propertyText = null;
   }
}
