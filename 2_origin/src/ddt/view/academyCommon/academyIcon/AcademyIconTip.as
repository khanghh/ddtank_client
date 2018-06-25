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
         var _content:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyIcon.contentTxt");
         addChild(_content);
         _textFrameArray.push(_content);
         var _contentII:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyIcon.contentTxtII");
         addChild(_contentII);
         _textFrameArray.push(_contentII);
         var _contentIII:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyIcon.contentTxtIII");
         addChild(_contentIII);
         _textFrameArray.push(_contentIII);
         _contentLabel = ComponentFactory.Instance.model.getSet("academyCommon.academyIcon.contentLabelTF");
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(data:Object) : void
      {
         _tipData = data as PlayerInfo;
         if(_tipData)
         {
            update();
         }
      }
      
      public function get tipWidth() : int
      {
         return 0;
      }
      
      public function set tipWidth(w:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function update() : void
      {
         var i:int = 0;
         var num:int = 0;
         var number:int = 0;
         var isSelf:* = PlayerManager.Instance.Self.ID == _tipData.ID;
         var _loc5_:* = false;
         _textFrameArray[2].visible = _loc5_;
         _loc5_ = _loc5_;
         _textFrameArray[1].visible = _loc5_;
         _textFrameArray[0].visible = _loc5_;
         if(_tipData.apprenticeshipState == 2 || _tipData.apprenticeshipState == 3)
         {
            for(i = 0; i <= (_tipData.getMasterOrApprentices().length >= 3?2:_tipData.getMasterOrApprentices().length); )
            {
               if(_tipData.getMasterOrApprentices().list[i] && _tipData.getMasterOrApprentices().list[i] != "")
               {
                  _textFrameArray[i].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.master",_tipData.getMasterOrApprentices().list[i]);
                  _textFrameArray[i].setTextFormat(_contentLabel,0,_tipData.getMasterOrApprentices().list[i].length);
                  _textFrameArray[i].visible = true;
               }
               else
               {
                  num = 3 - _tipData.getMasterOrApprentices().length;
                  _textFrameArray[i].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.masterExplanation",num);
                  _textFrameArray[i].visible = true;
               }
               i++;
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
            else if(!isSelf)
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
               if(!isSelf)
               {
                  number = 3 - _tipData.getMasterOrApprentices().length;
                  _textFrameArray[0].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.masterExplanation",number);
                  _textFrameArray[0].visible = true;
               }
            }
            else if(!isSelf)
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
         var i:int = 0;
         var isSelf:* = PlayerManager.Instance.Self.ID == _tipData.ID;
         _bg.width = getMaxWidth();
         var length:int = 0;
         for(i = 0; i < _textFrameArray.length; )
         {
            if(_textFrameArray[i].visible)
            {
               length++;
            }
            i++;
         }
         _bg.height = length * 22;
      }
      
      private function getApprenticesNum() : String
      {
         var num:int = 3 - _tipData.getMasterOrApprentices().length;
         switch(int(num) - 1)
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
         var i:int = 0;
         var maxWidth:int = 0;
         for(i = 0; i < _textFrameArray.length; )
         {
            if(_textFrameArray[i].visible && _textFrameArray[i].width > maxWidth)
            {
               maxWidth = _textFrameArray[i].width;
            }
            i++;
         }
         return maxWidth + 10;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         if(_textFrameArray)
         {
            for(i = 0; i < _textFrameArray.length; )
            {
               _textFrameArray[i].dispose();
               _textFrameArray[i] = null;
               i++;
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
