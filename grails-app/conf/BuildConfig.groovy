grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6

grails.project.fork = [
    //  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    test: false,
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

grails.project.dependency.resolver = "maven"
grails.project.dependency.resolution = {
    inherits("global") {}
    log "warn"
    legacyResolve false
    repositories {
        grailsCentral()
        mavenLocal()
        mavenRepo "http://labs.technipelago.se/repo/plugins-releases-local/"
        mavenCentral()
    }
    dependencies {
        // See https://jira.grails.org/browse/GPHIB-30
        test("javax.validation:validation-api:1.1.0.Final") { export = false }
        test("org.hibernate:hibernate-validator:5.0.3.Final") { export = false }
        // Without xhtmlrenderer and itext we get unresolved dependencies in the Jenkins build!?
        // I tried 'legacyResolve true' but it did not help. Strange...
        compile "org.xhtmlrenderer:core-renderer:R8"
        compile "com.lowagie:itext:2.1.0"
    }

    plugins {
        build(":release:3.0.1",
                ":rest-client-builder:1.0.3") {
            export = false
        }
        test(":hibernate4:4.3.6.1") {
            excludes "net.sf.ehcache:ehcache-core"  // remove this when http://jira.grails.org/browse/GPHIB-18 is resolved
            export = false
        }

        test(":codenarc:0.22") { export = false }
        test(":code-coverage:2.0.3-3") { export = false }

        compile(":avatar:0.6.3") {
            excludes 'xercesImpl', 'xml-apis'
        }

        compile(":qrcode:0.7")
        compile(":rendering:1.0.0")
        compile ":selection:0.9.8"
        compile ":sequence-generator:1.1"
        compile ":selection-repository:0.9.3"
        compile ":recent-domain:0.6.0"
        compile ":decorator:1.1"
        compile ":user-tag:0.6"

        compile ":crm-core:2.4.0-SNAPSHOT"
        compile ":crm-contact:2.4.0-SNAPSHOT"
        compile ":crm-security:2.4.0-SNAPSHOT"
        compile ":crm-tags:2.4.0-SNAPSHOT"
        compile ":crm-feature:2.4.0-SNAPSHOT"
        compile ":crm-ui-bootstrap:2.4.0-SNAPSHOT"
    }
}
