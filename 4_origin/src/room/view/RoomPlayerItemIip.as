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
         var _content:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt");
         _content.visible = false;
         addChild(_content);
         _textFrameArray.push(_content);
         var _content2:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt2");
         _content2.visible = false;
         addChild(_content2);
         _textFrameArray.push(_content2);
         var _content3:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt3");
         _content3.visible = false;
         addChild(_content3);
         _textFrameArray.push(_content3);
         var _content4:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt4");
         _content4.visible = false;
         addChild(_content4);
         _textFrameArray.push(_content4);
         var _content5:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ddtroom.roomPlayerItemTips.contentTxt5");
         _content5.visible = false;
         addChild(_content5);
         _textFrameArray.push(_content5);
         _contentLabel = ComponentFactory.Instance.model.getSet("ddtroom.roomPlayerItemTips.contentLabelTF");
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(data:Object) : void
      {
         _tipData = data;
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
      
      private function returnFilterFrameText(str:String) : FilterFrameText
      {
         var i:int = 0;
         var obj:* = null;
         var txt:* = null;
         for(i = 0; i < _textFrameArray.length; )
         {
            obj = _textFrameArray[i];
            if(obj.text == "" || obj.text == str)
            {
               txt = obj;
               break;
            }
            i++;
         }
         return obj;
      }
      
      private function isVisibleFunction() : void
      {
         var trueCount:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _textFrameArray;
         for each(var obj in _textFrameArray)
         {
            if(obj.text == "")
            {
               obj.visible = false;
            }
            else
            {
               trueCount++;
               obj.visible = true;
            }
         }
         if(trueCount == 0)
         {
            this.visible = false;
         }
      }
      
      private function reset() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _textFrameArray;
         for each(var txt in _textFrameArray)
         {
            txt.text = "";
         }
      }
      
      private function update() : void
      {
         var playerInfo:* = null;
         var i:int = 0;
         var txt2:* = null;
         var contentTxt2:* = null;
         var txt3:* = null;
         var contentTxt3:* = null;
         var k:int = 0;
         var txt4:* = null;
         var contentTxt4:* = null;
         var txt5:* = null;
         var contentTxt5:* = null;
         if(_tipData is PlayerInfo)
         {
            playerInfo = _tipData as PlayerInfo;
            if(playerInfo.ID == playerInfo.ID)
            {
               if(playerInfo.apprenticeshipState == 2 || playerInfo.apprenticeshipState == 3)
               {
                  for(i = 0; i <= (playerInfo.getMasterOrApprentices().length >= 3?2:playerInfo.getMasterOrApprentices().length); )
                  {
                     if(playerInfo.getMasterOrApprentices().list[i] && playerInfo.getMasterOrApprentices().list[i] != "")
                     {
                        _textFrameArray[i].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.master",playerInfo.getMasterOrApprentices().list[i]);
                        _textFrameArray[i].setTextFormat(_contentLabel,0,playerInfo.getMasterOrApprentices().list[i].length);
                     }
                     i++;
                  }
               }
               else if(playerInfo.apprenticeshipState == 1)
               {
                  if(playerInfo.getMasterOrApprentices().list[0] && playerInfo.getMasterOrApprentices().list[0] != "")
                  {
                     txt2 = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.Apprentice",playerInfo.getMasterOrApprentices().list[0]);
                     contentTxt2 = returnFilterFrameText(txt2);
                     if(contentTxt2)
                     {
                        contentTxt2.text = txt2;
                        contentTxt2.setTextFormat(_contentLabel,0,playerInfo.getMasterOrApprentices().list[0].length);
                     }
                  }
               }
               if(playerInfo.IsMarried)
               {
                  txt3 = LanguageMgr.GetTranslation("ddt.room.roomPlayerItemTip.SpouseNameTxt",playerInfo.SpouseName);
                  contentTxt3 = returnFilterFrameText(txt3);
                  if(contentTxt3)
                  {
                     contentTxt3.text = txt3;
                     contentTxt3.setTextFormat(_contentLabel,14,txt3.length);
                  }
               }
            }
            else
            {
               if(playerInfo.apprenticeshipState == 2 || playerInfo.apprenticeshipState == 3)
               {
                  for(k = 0; k <= (playerInfo.getMasterOrApprentices().length >= 3?2:playerInfo.getMasterOrApprentices().length); )
                  {
                     if(playerInfo.getMasterOrApprentices().list[k] && playerInfo.getMasterOrApprentices().list[k] != "")
                     {
                        _textFrameArray[k].text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.master",playerInfo.getMasterOrApprentices().list[k]);
                        _textFrameArray[k].setTextFormat(_contentLabel,0,playerInfo.getMasterOrApprentices().list[k].length);
                     }
                     k++;
                  }
               }
               else if(playerInfo.apprenticeshipState == 1)
               {
                  if(playerInfo.getMasterOrApprentices().list[0] && playerInfo.getMasterOrApprentices().list[0] != "")
                  {
                     txt4 = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyIcon.AcademyIconTip.Apprentice",playerInfo.getMasterOrApprentices().list[0]);
                     contentTxt4 = returnFilterFrameText(txt4);
                     if(contentTxt4)
                     {
                        contentTxt4.text = txt4;
                        contentTxt4.setTextFormat(_contentLabel,0,playerInfo.getMasterOrApprentices().list[0].length);
                     }
                  }
               }
               if(playerInfo.IsMarried)
               {
                  txt5 = LanguageMgr.GetTranslation("ddt.room.roomPlayerItemTip.SpouseNameTxt",playerInfo.SpouseName);
                  contentTxt5 = returnFilterFrameText(txt5);
                  if(contentTxt5)
                  {
                     contentTxt5.text = txt5;
                     contentTxt5.setTextFormat(_contentLabel,0,playerInfo.SpouseName.length);
                  }
               }
            }
         }
         isVisibleFunction();
         updateBgSize();
      }
      
      private function updateBgSize() : void
      {
         var i:int = 0;
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
