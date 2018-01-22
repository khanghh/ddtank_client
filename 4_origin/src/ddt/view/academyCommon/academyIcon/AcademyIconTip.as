package ddt.view.academyCommon.academyIcon
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class AcademyIconTip extends Sprite implements Disposeable, ITip
   {
      
      public static const MAX_HEIGHT:int = 70;
      
      public static const MIN_HEIGHT:int = 22;
       
      
      private var _tipData:PlayerInfo;
      
      private var _contentLabel:TextFormat;
      
      private var _bg:ScaleBitmapImage;
      
      private var _textFrameArray:Vector.<FilterFrameText>;
      
      public function AcademyIconTip()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyIcon.academyIconTipsBG");
         addChild(_bg);
         _textFrameArray = new Vector.<FilterFrameText>();
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyIcon.contentTxt");
         addChild(_loc3_);
         _textFrameArray.push(_loc3_);
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyIcon.contentTxtII");
         addChild(_loc1_);
         _textFrameArray.push(_loc1_);
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyIcon.contentTxtIII");
         addChild(_loc2_);
         _textFrameArray.push(_loc2_);
         _contentLabel = ComponentFactory.Instance.model.getSet("academyCommon.academyIcon.contentLabelTF");
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1 as PlayerInfo;
         if(_tipData)
         {
            update();
         }
      }
      
      public function get tipWidth() : int
      {
         return 0;
      }
      
      public function set tipWidth(param1:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function update() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = PlayerManager.Instance.Self.ID == _tipData.ID;
         var _loc5_:* = false;
         _textFrameArray[2].visible = _loc5_;
         _loc5_ = _loc5_;
         _textFrameArray[1].visible = _loc5_;
         _textFrameArray[0].visible = _loc5_;
         if(_tipData.apprenticeshipState == 2 || _tipData.apprenticeshipState == 3)
         {
            _loc4_ = 0;
            while(_loc4_ <= (_tipData.getMasterOrApprentices().length >= 3?2:_tipData.getMasterOrApprentices().length))
            {
               if(_tipData.getMasterOrApprentices().list[_loc4_] && _tipData.getMasterOrApprentices().list[_loc4_] != "")
               {
                  _textFrameArray[_loc4_].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.master",_tipData.getMasterOrApprentices().list[_loc4_]);
                  _textFrameArray[_loc4_].setTextFormat(_contentLabel,0,_tipData.getMasterOrApprentices().list[_loc4_].length);
                  _textFrameArray[_loc4_].visible = true;
               }
               else
               {
                  _loc1_ = 3 - _tipData.getMasterOrApprentices().length;
                  _textFrameArray[_loc4_].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.masterExplanation",_loc1_);
                  _textFrameArray[_loc4_].visible = true;
               }
               _loc4_++;
            }
         }
         else if(_tipData.apprenticeshipState == 1)
         {
            if(_tipData.getMasterOrApprentices().list[0] && _tipData.getMasterOrApprentices().list[0] != "")
            {
               _textFrameArray[0].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.Apprentice",_tipData.getMasterOrApprentices().list[0]);
               _textFrameArray[0].setTextFormat(_contentLabel,0,_tipData.getMasterOrApprentices().list[0].length);
               _textFrameArray[0].visible = true;
            }
            else if(!_loc3_)
            {
               _textFrameArray[0].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.ApprenticeExplanation");
               _textFrameArray[0].visible = true;
            }
            _loc5_ = false;
            _textFrameArray[2].visible = _loc5_;
            _textFrameArray[1].visible = _loc5_;
         }
         else if(_tipData.ID == PlayerManager.Instance.Self.ID && _tipData.apprenticeshipState == 0)
         {
            _textFrameArray[0].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.ApprenticeNull");
            _textFrameArray[0].visible = true;
            _loc5_ = false;
            _textFrameArray[2].visible = _loc5_;
            _textFrameArray[1].visible = _loc5_;
         }
         else
         {
            if(_tipData.Grade >= 21)
            {
               if(!_loc3_)
               {
                  _loc2_ = 3 - _tipData.getMasterOrApprentices().length;
                  _textFrameArray[0].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.masterExplanation",_loc2_);
                  _textFrameArray[0].visible = true;
               }
            }
            else if(!_loc3_)
            {
               _textFrameArray[0].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.ApprenticeExplanation");
               _textFrameArray[0].visible = true;
            }
            _loc5_ = false;
            _textFrameArray[2].visible = _loc5_;
            _textFrameArray[1].visible = _loc5_;
         }
         updateBgSize();
      }
      
      private function updateBgSize() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = PlayerManager.Instance.Self.ID == _tipData.ID;
         _bg.width = getMaxWidth();
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _textFrameArray.length)
         {
            if(_textFrameArray[_loc3_].visible)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         _bg.height = _loc1_ * 22;
      }
      
      private function getApprenticesNum() : String
      {
         var _loc1_:int = 3 - _tipData.getMasterOrApprentices().length;
         switch(int(_loc1_) - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.1");
            case 1:
               return LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.2");
            case 2:
               return LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.3");
         }
      }
      
      private function getMaxWidth() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _textFrameArray.length)
         {
            if(_textFrameArray[_loc2_].visible && _textFrameArray[_loc2_].width > _loc1_)
            {
               _loc1_ = _textFrameArray[_loc2_].width;
            }
            _loc2_++;
         }
         return _loc1_ + 10;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_textFrameArray)
         {
            _loc1_ = 0;
            while(_loc1_ < _textFrameArray.length)
            {
               _textFrameArray[_loc1_].dispose();
               _textFrameArray[_loc1_] = null;
               _loc1_++;
            }
         }
         if(_bg)
         {
            _bg.dispose();
            _bg = null;
         }
         _contentLabel = null;
      }
   }
}
