package room.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import flash.text.TextFormat;
   
   public class RoomPlayerItemIip extends BaseTip implements Disposeable, ITip
   {
      
      public static const MAX_HEIGHT:int = 70;
      
      public static const MIN_HEIGHT:int = 22;
       
      
      private var _textFrameArray:Vector.<FilterFrameText>;
      
      private var _contentLabel:TextFormat;
      
      private var _bg:ScaleBitmapImage;
      
      public function RoomPlayerItemIip()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTipsBG");
         addChild(_bg);
         _textFrameArray = new Vector.<FilterFrameText>();
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt");
         _loc1_.visible = false;
         addChild(_loc1_);
         _textFrameArray.push(_loc1_);
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt2");
         _loc5_.visible = false;
         addChild(_loc5_);
         _textFrameArray.push(_loc5_);
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt3");
         _loc4_.visible = false;
         addChild(_loc4_);
         _textFrameArray.push(_loc4_);
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt4");
         _loc3_.visible = false;
         addChild(_loc3_);
         _textFrameArray.push(_loc3_);
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt5");
         _loc2_.visible = false;
         addChild(_loc2_);
         _textFrameArray.push(_loc2_);
         _contentLabel = ComponentFactory.Instance.model.getSet("ddtroom.roomPlayerItemTips.contentLabelTF");
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         _tipData = param1;
         if(_tipData)
         {
            this.visible = true;
            reset();
            update();
         }
         else
         {
            this.visible = false;
         }
      }
      
      private function returnFilterFrameText(param1:String) : FilterFrameText
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ < _textFrameArray.length)
         {
            _loc2_ = _textFrameArray[_loc4_];
            if(_loc2_.text == "" || _loc2_.text == param1)
            {
               _loc3_ = _loc2_;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function isVisibleFunction() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _textFrameArray;
         for each(var _loc1_ in _textFrameArray)
         {
            if(_loc1_.text == "")
            {
               _loc1_.visible = false;
            }
            else
            {
               _loc2_++;
               _loc1_.visible = true;
            }
         }
         if(_loc2_ == 0)
         {
            this.visible = false;
         }
      }
      
      private function reset() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _textFrameArray;
         for each(var _loc1_ in _textFrameArray)
         {
            _loc1_.text = "";
         }
      }
      
      private function update() : void
      {
         var _loc9_:* = null;
         var _loc11_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc10_:int = 0;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         if(_tipData is PlayerInfo)
         {
            _loc9_ = _tipData as PlayerInfo;
            if(_loc9_.ID == _loc9_.ID)
            {
               if(_loc9_.apprenticeshipState == 2 || _loc9_.apprenticeshipState == 3)
               {
                  _loc11_ = 0;
                  while(_loc11_ <= (_loc9_.getMasterOrApprentices().length >= 3?2:_loc9_.getMasterOrApprentices().length))
                  {
                     if(_loc9_.getMasterOrApprentices().list[_loc11_] && _loc9_.getMasterOrApprentices().list[_loc11_] != "")
                     {
                        _textFrameArray[_loc11_].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.master",_loc9_.getMasterOrApprentices().list[_loc11_]);
                        _textFrameArray[_loc11_].setTextFormat(_contentLabel,0,_loc9_.getMasterOrApprentices().list[_loc11_].length);
                     }
                     _loc11_++;
                  }
               }
               else if(_loc9_.apprenticeshipState == 1)
               {
                  if(_loc9_.getMasterOrApprentices().list[0] && _loc9_.getMasterOrApprentices().list[0] != "")
                  {
                     _loc1_ = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.Apprentice",_loc9_.getMasterOrApprentices().list[0]);
                     _loc3_ = returnFilterFrameText(_loc1_);
                     if(_loc3_)
                     {
                        _loc3_.text = _loc1_;
                        _loc3_.setTextFormat(_contentLabel,0,_loc9_.getMasterOrApprentices().list[0].length);
                     }
                  }
               }
               if(_loc9_.IsMarried)
               {
                  _loc2_ = LanguageMgr.GetTranslation("ddt.room.roomPlayerItemTip.SpouseNameTxt",_loc9_.SpouseName);
                  _loc5_ = returnFilterFrameText(_loc2_);
                  if(_loc5_)
                  {
                     _loc5_.text = _loc2_;
                     _loc5_.setTextFormat(_contentLabel,14,_loc2_.length);
                  }
               }
            }
            else
            {
               if(_loc9_.apprenticeshipState == 2 || _loc9_.apprenticeshipState == 3)
               {
                  _loc10_ = 0;
                  while(_loc10_ <= (_loc9_.getMasterOrApprentices().length >= 3?2:_loc9_.getMasterOrApprentices().length))
                  {
                     if(_loc9_.getMasterOrApprentices().list[_loc10_] && _loc9_.getMasterOrApprentices().list[_loc10_] != "")
                     {
                        _textFrameArray[_loc10_].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.master",_loc9_.getMasterOrApprentices().list[_loc10_]);
                        _textFrameArray[_loc10_].setTextFormat(_contentLabel,0,_loc9_.getMasterOrApprentices().list[_loc10_].length);
                     }
                     _loc10_++;
                  }
               }
               else if(_loc9_.apprenticeshipState == 1)
               {
                  if(_loc9_.getMasterOrApprentices().list[0] && _loc9_.getMasterOrApprentices().list[0] != "")
                  {
                     _loc4_ = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.Apprentice",_loc9_.getMasterOrApprentices().list[0]);
                     _loc7_ = returnFilterFrameText(_loc4_);
                     if(_loc7_)
                     {
                        _loc7_.text = _loc4_;
                        _loc7_.setTextFormat(_contentLabel,0,_loc9_.getMasterOrApprentices().list[0].length);
                     }
                  }
               }
               if(_loc9_.IsMarried)
               {
                  _loc6_ = LanguageMgr.GetTranslation("ddt.room.roomPlayerItemTip.SpouseNameTxt",_loc9_.SpouseName);
                  _loc8_ = returnFilterFrameText(_loc6_);
                  if(_loc8_)
                  {
                     _loc8_.text = _loc6_;
                     _loc8_.setTextFormat(_contentLabel,0,_loc9_.SpouseName.length);
                  }
               }
            }
         }
         isVisibleFunction();
         updateBgSize();
      }
      
      private function updateBgSize() : void
      {
         var _loc2_:int = 0;
         _bg.width = getMaxWidth();
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _textFrameArray.length)
         {
            if(_textFrameArray[_loc2_].visible)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         _bg.height = _loc1_ * 22;
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
      
      override public function dispose() : void
      {
         _textFrameArray = null;
         if(_contentLabel)
         {
            _contentLabel = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
