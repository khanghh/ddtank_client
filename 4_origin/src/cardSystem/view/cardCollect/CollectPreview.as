package cardSystem.view.cardCollect
{
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsInfo;
   import cardSystem.data.SetsPropertyInfo;
   import cardSystem.elements.PreviewCard;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class CollectPreview extends Sprite implements Disposeable
   {
      
      public static const PREVIEWCARD_ALL_LENGTH:int = 350;
      
      public static const PREVIEWCARD_WIDHT:int = 66;
       
      
      private var _bg:MovieImage;
      
      private var _setsName:GradientText;
      
      private var _stroyBG:MovieImage;
      
      private var _flower:Bitmap;
      
      private var _stroy:FilterFrameText;
      
      private var _itemInfo:SetsInfo;
      
      private var _previewCardVec:Vector.<PreviewCard>;
      
      private var _setsPropBG:Bitmap;
      
      private var _propExplain:GradientText;
      
      private var _propDescript:TextArea;
      
      public function CollectPreview()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.BG");
         _setsName = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.setsName");
         _stroyBG = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.BG1");
         _flower = ComponentFactory.Instance.creatBitmap("asset.ddtcardSytems.bg2");
         _stroy = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.story");
         _setsPropBG = ComponentFactory.Instance.creatBitmap("CollectPreview.setsPropBG");
         _propExplain = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.propExplain");
         _propDescript = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.propArea");
         addChild(_bg);
         addChild(_stroyBG);
         addChild(_flower);
         addChild(_stroy);
         addChild(_setsPropBG);
         addChild(_propExplain);
         addChild(_propDescript);
         addChild(_setsName);
         _previewCardVec = new Vector.<PreviewCard>(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _previewCardVec[_loc1_] = new PreviewCard();
            addChild(_previewCardVec[_loc1_]);
            _previewCardVec[_loc1_].y = 148;
            _loc1_++;
         }
         _propExplain.text = LanguageMgr.GetTranslation("ddt.cardSystem.preview.propExplain");
      }
      
      public function set info(param1:SetsInfo) : void
      {
         if(_itemInfo == param1)
         {
            return;
         }
         _itemInfo = param1;
         upView();
      }
      
      private function upView() : void
      {
         var _loc12_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc14_:* = null;
         var _loc17_:* = null;
         var _loc13_:Vector.<CardInfo> = CardManager.Instance.model.getSetsCardFromCardBag(_itemInfo.ID);
         _setsName.text = _itemInfo.name;
         _setsName.x = _bg.x + _bg.width / 2 - _setsName.textWidth / 2;
         _stroy.text = "    " + _itemInfo.storyDescript;
         var _loc7_:int = _itemInfo.cardIdVec.length;
         _loc12_ = 0;
         while(_loc12_ < 5)
         {
            if(_loc12_ < _loc7_)
            {
               _previewCardVec[_loc12_].cardId = _itemInfo.cardIdVec[_loc12_];
               _previewCardVec[_loc12_].visible = true;
               if(_loc13_.length > 0)
               {
                  _loc9_ = 0;
                  while(_loc9_ < _loc13_.length)
                  {
                     if(_previewCardVec[_loc12_].cardId == _loc13_[_loc9_].TemplateID)
                     {
                        _previewCardVec[_loc12_].cardInfo = _loc13_[_loc9_];
                        break;
                     }
                     if(_loc9_ == _loc13_.length - 1)
                     {
                        _previewCardVec[_loc12_].cardInfo = null;
                     }
                     _loc9_++;
                  }
               }
               else
               {
                  _previewCardVec[_loc12_].cardInfo = null;
               }
            }
            else
            {
               _previewCardVec[_loc12_].visible = false;
            }
            _loc12_++;
         }
         var _loc1_:int = 350 / _loc7_;
         var _loc10_:int = 18 + _loc1_ / 2 - 66 / 2 + 5;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _previewCardVec[_loc4_].x = _loc10_;
            _loc10_ = _loc10_ + (_loc1_ + 4);
            _loc4_++;
         }
         var _loc18_:Vector.<SetsPropertyInfo> = CardManager.Instance.model.setsList[_itemInfo.ID];
         var _loc6_:int = _loc18_.length;
         var _loc15_:String = "";
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc14_ = _loc18_[_loc8_].value.split("|");
            if(_loc14_.length == 4)
            {
               _loc17_ = _loc14_[0] + "/" + _loc14_[1] + "/" + _loc14_[2] + "/" + _loc14_[3] + LanguageMgr.GetTranslation("cardSystem.preview.descript.level");
               _loc15_ = _loc15_.concat(LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp1") + _loc18_[_loc8_].condition + LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp2") + " " + _loc18_[_loc8_].Description.replace("{0}",_loc17_));
            }
            else
            {
               _loc15_ = _loc15_.concat(LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp1") + _loc18_[_loc8_].condition + LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp2") + " " + _loc18_[_loc8_].Description.replace("{0}",_loc14_[0]));
            }
            _loc15_ = _loc15_.concat("\n\n");
            _loc8_++;
         }
         _propDescript.text = _loc15_;
         var _loc5_:TextFormat = new TextFormat();
         _loc5_.bold = true;
         var _loc11_:int = 0;
         var _loc16_:int = 0;
         var _loc3_:String = LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp1");
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp2");
         while(_loc15_.indexOf(_loc3_) > -1)
         {
            if(_loc11_ != 0)
            {
               _loc16_ = _loc16_ + (_loc3_.length + _loc2_.length + 1 + _loc15_.indexOf(_loc3_));
            }
            _propDescript.textField.setTextFormat(_loc5_,_loc16_,_loc16_ + _loc3_.length + _loc2_.length + 2);
            _loc15_ = _loc15_.substr(_loc15_.indexOf(_loc2_) + _loc2_.length + 1,_loc15_.length);
            _loc11_++;
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _itemInfo = null;
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _setsName = null;
         _stroyBG = null;
         _stroy = null;
         _loc1_ = 0;
         while(_loc1_ < _previewCardVec.length)
         {
            _previewCardVec[_loc1_] = null;
            _loc1_++;
         }
         _previewCardVec = null;
         _setsPropBG = null;
         _propExplain = null;
         _propDescript = null;
         _flower = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
