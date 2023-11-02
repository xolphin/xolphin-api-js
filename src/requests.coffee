class CreateCertificateRequest
  constructor: (@product, @years, @csr, @dcvType) ->
    @subjectAlternativeNames = []
    @dcv = []
    @certenroll_email = ''
    @company = ''
    @department = ''
    @address = ''
    @zipcode = ''
    @city = ''
    @province = ''
    @country = ''
    @approverFirstName = ''
    @approverLastName = ''
    @approverEmail = ''
    @approverPhone = ''
    @approverRepresentativePosition = ''
    @approverRepresentativeFirstName = ''
    @approverRepresentativeLastName = ''
    @approverRepresentativeEmail = ''
    @approverRepresentativePhone = ''
    @kvk = ''
    @reference = ''
    @language = ''

  toArray: () =>
    result = {
      product: @product,
      years: @years,
      csr: @csr,
      dcvType: @dcvType
    }

    result['subjectAlternativeNames'] = @subjectAlternativeNames.join(',') if @subjectAlternativeNames.length > 0
    result['dcv'] = JSON.stringify(@dcv) if @dcv.length > 0
    result['certenroll_email'] = @certenroll_email if @certenroll_email != ''
    result['company'] = @company if @company != ''
    result['department'] = @department if @department != ''
    result['address'] = @address if @address != ''
    result['zipcode'] = @zipcode if @zipcode != ''
    result['city'] = @city if @city != ''
    result['province'] = @province if @province != ''
    result['country'] = @country if @country != ''
    result['approverFirstName'] = @approverFirstName if @approverFirstName != ''
    result['approverLastName'] = @approverLastName if @approverLastName != ''
    result['approverEmail'] = @approverEmail if @approverEmail != ''
    result['approverPhone'] = @approverPhone if @approverPhone != ''
    result['approverRepresentativePosition'] = @approverRepresentativePosition if @approverRepresentativePosition != ''
    result['approverRepresentativeFirstName'] = @approverRepresentativeFirstName if @approverRepresentativeFirstName != ''
    result['approverRepresentativeLastName'] = @approverRepresentativeLastName if @approverRepresentativeLastName != ''
    result['approverRepresentativeEmail'] = @approverRepresentativeEmail if @approverRepresentativeEmail != ''
    result['approverRepresentativePhone'] = @approverRepresentativePhone if @approverRepresentativePhone != ''
    result['kvk'] = @kvk if @kvk != ''
    result['reference'] = @reference if @reference != ''
    result['language'] = @language if @language != ''

    result

class CreateEERequest
  constructor: () ->
    @csr = ''
    @subjectAlternativeNames = []
    @approverRepresentativePosition = ''
    @approverRepresentativeFirstName = ''
    @approverRepresentativeLastName = ''
    @approverRepresentativeEmail = ''
    @approverRepresentativePhone = ''
    @approverFirstName = ''
    @approverLastName = ''
    @approverEmail = ''
    @approverPhone = ''
    @dcvType = 'FILE'
    @validate = false

  toArray: () =>
    result = {}

    result['subjectAlternativeNames'] = @subjectAlternativeNames.join(',') if @subjectAlternativeNames.length > 0
    
    result = {
      csr: @csr,
      approverFirstName: @approverFirstName,
      approverLastName: @approverLastName,
      approverEmail: @approverEmail,
      approverPhone: @approverPhone,
      dcvType: @dcvType,
      validate: if @validate then 1 else 0
    }

    result['approverRepresentativePosition'] = @approverRepresentativePosition if @approverRepresentativePosition != ''
    result['approverRepresentativeFirstName'] = @approverRepresentativeFirstName if @approverRepresentativeFirstName != ''
    result['approverRepresentativeLastName'] = @approverRepresentativeLastName if @approverRepresentativeLastName != ''
    result['approverRepresentativeEmail'] = @approverRepresentativeEmail if @approverRepresentativeEmail != ''
    result['approverRepresentativePhone'] = @approverRepresentativePhone if @approverRepresentativePhone != ''

    result

class ReissueCertificateRequest
  constructor: (@csr, @dcvType) ->
    @subjectAlternativeNames = []
    @dcv = []
    @certenroll_email = ''
    @company = ''
    @department = ''
    @address = ''
    @zipcode = ''
    @city = ''
    @province = ''
    @country = ''
    @approverFirstName = ''
    @approverLastName = ''
    @approverEmail = ''
    @approverPhone = ''
    @approverRepresentativePosition = ''
    @approverRepresentativeFirstName = ''
    @approverRepresentativeLastName = ''
    @approverRepresentativeEmail = ''
    @approverRepresentativePhone = ''
    @kvk = ''
    @reference = ''
    @language = ''

  toArray: () =>
    result = {
      csr: @csr,
      dcvType: @dcvType
    }

    result['subjectAlternativeNames'] = @subjectAlternativeNames.join(',') if @subjectAlternativeNames.length > 0
    result['dcv'] = JSON.stringify(@dcv) if @dcv.length > 0
    result['certenroll_email'] = @certenroll_email if @certenroll_email != ''
    result['company'] = @company if @company != ''
    result['department'] = @department if @department != ''
    result['address'] = @address if @address != ''
    result['zipcode'] = @zipcode if @zipcode != ''
    result['city'] = @city if @city != ''
    result['province'] = @province if @province != ''
    result['country'] = @country if @country != ''
    result['approverFirstName'] = @approverFirstName if @approverFirstName != ''
    result['approverLastName'] = @approverLastName if @approverLastName != ''
    result['approverEmail'] = @approverEmail if @approverEmail != ''
    result['approverPhone'] = @approverPhone if @approverPhone != ''
    result['approverRepresentativePosition'] = @approverRepresentativePosition if @approverRepresentativePosition != ''
    result['approverRepresentativeFirstName'] = @approverRepresentativeFirstName if @approverRepresentativeFirstName != ''
    result['approverRepresentativeLastName'] = @approverRepresentativeLastName if @approverRepresentativeLastName != ''
    result['approverRepresentativeEmail'] = @approverRepresentativeEmail if @approverRepresentativeEmail != ''
    result['approverRepresentativePhone'] = @approverRepresentativePhone if @approverRepresentativePhone != ''
    result['kvk'] = @kvk if @kvk != ''
    result['reference'] = @reference if @reference != ''
    result['language'] = @language if @language != ''

    result

class RenewCertificateRequest
  constructor: (@product, @years, @csr, @dcvType) ->
    @subjectAlternativeNames = []
    @dcv = []
    @certenroll_email = ''
    @company = ''
    @department = ''
    @address = ''
    @zipcode = ''
    @city = ''
    @province = ''
    @country = ''
    @approverFirstName = ''
    @approverLastName = ''
    @approverEmail = ''
    @approverPhone = ''
    @approverRepresentativePosition = ''
    @approverRepresentativeFirstName = ''
    @approverRepresentativeLastName = ''
    @approverRepresentativeEmail = ''
    @approverRepresentativePhone = ''
    @kvk = ''
    @reference = ''
    @language = ''

  toArray: () =>
    result = {
      product: @product,
      years: @years,
      csr: @csr,
      dcvType: @dcvType
    }

    result['subjectAlternativeNames'] = @subjectAlternativeNames.join(',') if @subjectAlternativeNames.length > 0
    result['dcv'] = JSON.stringify(@dcv) if @dcv.length > 0
    result['certenroll_email'] = @certenroll_email if @certenroll_email != ''
    result['company'] = @company if @company != ''
    result['department'] = @department if @department != ''
    result['address'] = @address if @address != ''
    result['zipcode'] = @zipcode if @zipcode != ''
    result['city'] = @city if @city != ''
    result['province'] = @province if @province != ''
    result['country'] = @country if @country != ''
    result['approverFirstName'] = @approverFirstName if @approverFirstName != ''
    result['approverLastName'] = @approverLastName if @approverLastName != ''
    result['approverEmail'] = @approverEmail if @approverEmail != ''
    result['approverPhone'] = @approverPhone if @approverPhone != ''
    result['approverRepresentativePosition'] = @approverRepresentativePosition if @approverRepresentativePosition != ''
    result['approverRepresentativeFirstName'] = @approverRepresentativeFirstName if @approverRepresentativeFirstName != ''
    result['approverRepresentativeLastName'] = @approverRepresentativeLastName if @approverRepresentativeLastName != ''
    result['approverRepresentativeEmail'] = @approverRepresentativeEmail if @approverRepresentativeEmail != ''
    result['approverRepresentativePhone'] = @approverRepresentativePhone if @approverRepresentativePhone != ''
    result['kvk'] = @kvk if @kvk != ''
    result['reference'] = @reference if @reference != ''
    result['language'] = @language if @language != ''

    result

module.exports =
  CreateCertificateRequest:   CreateCertificateRequest
  CreateEERequest:            CreateEERequest,
  ReissueCertificateRequest:  ReissueCertificateRequest
  RenewCertificateRequest:    RenewCertificateRequest