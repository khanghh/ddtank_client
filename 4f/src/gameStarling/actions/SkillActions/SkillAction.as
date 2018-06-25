package gameStarling.actions.SkillActions{   import gameCommon.actions.BaseAction;   import gameStarling.animations.IAnimate;      public class SkillAction extends BaseAction   {                   private var _animate:IAnimate;            private var _onComplete:Function;            private var _onCompleteParams:Array;            public function SkillAction(animate:IAnimate, onComplete:Function = null, onCompleteParams:Array = null) { super(); }
            override public function execute() : void { }
            protected function finish() : void { }
   }}