package bagAndInfo.ReworkName
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class ReworkNameBattleTeam extends Frame
   {
       
      
      private var _nameErrorTxt:FilterFrameText = null;
      
      private var _tagErrorTxt:FilterFrameText = null;
      
      private var _nameInput:FilterFrameText = null;
      
      private var _tagInput:FilterFrameText = null;
      
      private var _nameCheck:TextButton = null;
      
      private var _tagCheck:TextButton = null;
      
      private var _submit:TextButton = null;
      
      private var _tagErrorImg:ScaleFrameImage = null;
      
      private var _nameErrorImg:ScaleFrameImage = null;
      
      private var _bagType:int = -1;
      
      private var _place:int = -1;
      
      public function ReworkNameBattleTeam()
      {
         super();
         initView();
         initEvent();
      }
      
      public function initialize(bagType:int, place:int) : void
      {
         _bagType = bagType;
         _place = place;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _submit.addEventListener("click",onClickHander);
         _nameCheck.addEventListener("click",onClickHander);
         _tagCheck.addEventListener("click",onClickHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,17),__onCheckInput);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,32),__onChangeResult);
      }
      
      private function __onCheckInput(e:PkgEvent) : void
      {
         var isName:Boolean = e.pkg.readBoolean();
         var errorType:int = e.pkg.readByte();
         var right:* = errorType == 0;
         if(isName)
         {
            _nameErrorImg.visible = true;
            _nameErrorTxt.setFrame(!!right?1:2);
            _nameErrorImg.setFrame(!!right?1:2);
            _nameErrorTxt.text = LanguageMgr.GetTranslation(getErrorDesc(1,right,errorType));
            PositionUtils.setPos(_nameErrorTxt,"reworkNameBattleTeam.nameErrorPos");
            _nameErrorTxt.visible = !right;
         }
         else
         {
            _tagErrorImg.visible = true;
            _tagErrorTxt.setFrame(!!right?1:2);
            _tagErrorImg.setFrame(!!right?1:2);
            _tagErrorTxt.text = LanguageMgr.GetTranslation(getErrorDesc(2,right,errorType));
            PositionUtils.setPos(_tagErrorTxt,"reworkNameBattleTeam.tagErrorPos");
            _tagErrorTxt.visible = !right;
         }
      }
      
      private function __onChangeResult(e:PkgEvent) : void
      {
         dispose();
      }
      
      private function getErrorDesc(type:int, value:Boolean, errorType:int = 0) : String
      {
         var link:String = "team.change.ok";
         if(!value)
         {
            link = "team.create.inputError" + errorType;
            if(errorType == 2)
            {
               link = link + type;
            }
         }
         return link;
      }
      
      private function onClickHander(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = event.target;
         if(_submit !== _loc2_)
         {
            if(_nameCheck !== _loc2_)
            {
               if(_tagCheck === _loc2_)
               {
                  SocketManager.Instance.out.sendTeamCheckInput(false,_tagInput.text);
               }
            }
            else
            {
               SocketManager.Instance.out.sendTeamCheckInput(true,_nameInput.text);
            }
         }
         else
         {
            SocketManager.Instance.out.sendChangeTeamName(_bagType,_place,_nameInput.text,_tagInput.text);
         }
      }
      
      protected function __responseHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _submit.removeEventListener("click",onClickHander);
         _nameCheck.removeEventListener("click",onClickHander);
         _tagCheck.removeEventListener("click",onClickHander);
         SocketManager.Instance.removeEventListener(PkgEvent.format(390,17),__onCheckInput);
         SocketManager.Instance.removeEventListener(PkgEvent.format(390,32),__onChangeResult);
      }
      
      private function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("battleTeam.title");
         var bg1:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.bg");
         addToContent(bg1);
         var bg2:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.bg2");
         addToContent(bg2);
         var inputBg1:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.inputBg1");
         addToContent(inputBg1);
         var inputBg2:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.inputBg2");
         addToContent(inputBg2);
         var nameTitle:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.nameTitle");
         nameTitle.text = LanguageMgr.GetTranslation("battleTeam.nameTitle");
         addToContent(nameTitle);
         var tagTitle:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.tagTitle");
         tagTitle.text = LanguageMgr.GetTranslation("battleTeam.tagTitle");
         addToContent(tagTitle);
         _nameInput = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.name");
         addToContent(_nameInput);
         _tagInput = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.tag");
         addToContent(_tagInput);
         _nameCheck = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.nameCheck");
         _nameCheck.text = LanguageMgr.GetTranslation("battleTeam.check");
         addToContent(_nameCheck);
         _tagCheck = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.tagCheck");
         _tagCheck.text = LanguageMgr.GetTranslation("battleTeam.check");
         addToContent(_tagCheck);
         _nameErrorTxt = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.nameError");
         _nameErrorTxt.text = LanguageMgr.GetTranslation("battleTeam.nameRemaind");
         addToContent(_nameErrorTxt);
         _tagErrorTxt = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.tagError");
         _tagErrorTxt.text = LanguageMgr.GetTranslation("battleTeam.tagRemaind");
         addToContent(_tagErrorTxt);
         _submit = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.submit");
         _submit.text = LanguageMgr.GetTranslation("battleTeam.submit");
         addToContent(_submit);
         _tagErrorImg = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.tagErrorImg");
         addToContent(_tagErrorImg);
         _tagErrorImg.visible = false;
         _nameErrorImg = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.nameErrorImg");
         addToContent(_nameErrorImg);
         _nameErrorImg.visible = false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
      }
   }
}
