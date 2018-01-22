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
      
      public function initialize(param1:int, param2:int) : void
      {
         _bagType = param1;
         _place = param2;
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
      
      private function __onCheckInput(param1:PkgEvent) : void
      {
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc2_:int = param1.pkg.readByte();
         var _loc4_:* = _loc2_ == 0;
         if(_loc3_)
         {
            _nameErrorImg.visible = true;
            _nameErrorTxt.setFrame(!!_loc4_?1:2);
            _nameErrorImg.setFrame(!!_loc4_?1:2);
            _nameErrorTxt.text = LanguageMgr.GetTranslation(getErrorDesc(1,_loc4_,_loc2_));
            PositionUtils.setPos(_nameErrorTxt,"reworkNameBattleTeam.nameErrorPos");
            _nameErrorTxt.visible = !_loc4_;
         }
         else
         {
            _tagErrorImg.visible = true;
            _tagErrorTxt.setFrame(!!_loc4_?1:2);
            _tagErrorImg.setFrame(!!_loc4_?1:2);
            _tagErrorTxt.text = LanguageMgr.GetTranslation(getErrorDesc(2,_loc4_,_loc2_));
            PositionUtils.setPos(_tagErrorTxt,"reworkNameBattleTeam.tagErrorPos");
            _tagErrorTxt.visible = !_loc4_;
         }
      }
      
      private function __onChangeResult(param1:PkgEvent) : void
      {
         dispose();
      }
      
      private function getErrorDesc(param1:int, param2:Boolean, param3:int = 0) : String
      {
         var _loc4_:String = "team.change.ok";
         if(!param2)
         {
            _loc4_ = "team.create.inputError" + param3;
            if(param3 == 2)
            {
               _loc4_ = _loc4_ + param1;
            }
         }
         return _loc4_;
      }
      
      private function onClickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.target;
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
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
         var _loc6_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.bg");
         addToContent(_loc6_);
         var _loc5_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.bg2");
         addToContent(_loc5_);
         var _loc2_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.inputBg1");
         addToContent(_loc2_);
         var _loc3_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.inputBg2");
         addToContent(_loc3_);
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.nameTitle");
         _loc4_.text = LanguageMgr.GetTranslation("battleTeam.nameTitle");
         addToContent(_loc4_);
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("reworkNameBattleTeam.tagTitle");
         _loc1_.text = LanguageMgr.GetTranslation("battleTeam.tagTitle");
         addToContent(_loc1_);
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
